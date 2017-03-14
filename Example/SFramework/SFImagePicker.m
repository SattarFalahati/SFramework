//
//  SFImagePicker.m
//  SFramework
//
//  Created by Sattar Falahati on 14/03/17.
//  Copyright © 2017 sattar_falahati. All rights reserved.
//

#import "SFImagePicker.h"

// Freamworks
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

// CELL
#import "SFImagePickerCell.h"

@interface SFImagePicker () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

// Image gallery
@property (nonatomic, strong) NSArray *arrDataSource;

// Check which camera is active
@property (nonatomic) BOOL frontCamera;

// AVFundation Objects
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureDeviceInput *deviceInput;
@property (strong, nonatomic) AVCaptureStillImageOutput *imageOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

// Photos framework
@property (strong, nonatomic) PHFetchResult *assetsFetchResults;
@property (strong, nonatomic) PHCachingImageManager *imageManager;

@end

@implementation SFImagePicker

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UI
    self.cameraView.alpha = 0;
    
    for (UIButton *btn in self.buttons) {
        [btn setBackgroundColor:RGBA(0, 0, 0, 0.1)];
        [btn makeViewCircular];
    }
    
    // Page options
    self.frontCamera = NO;
    
    // Initial Camera
    [self initCamera];
    
    // Initial gallery
    [self initialImageGalleryCollection];
    [self getAllPhotosFromGallery];
}

// MARK: - Initial Camera

- (void)initCamera
{
    //Capture Session
    self.captureSession = [AVCaptureSession new];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    
    //Add Input & device
    AVCaptureDevice *captureDevice;
    if (self.frontCamera) {
        captureDevice  = [self captureDeviceFront];
    }
    else {
        captureDevice = [self captureDeviceBack];
    }
    
    self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    
    if (!self.deviceInput) {
        NSLog(@"No Input");
    }
    
    [self.captureSession addInput:self.deviceInput];
    
    // Add Output
    self.imageOutput = [AVCaptureStillImageOutput new];
    self.imageOutput.outputSettings =@{AVVideoCodecJPEG: AVVideoCodecKey};
    [self.captureSession addOutput:self.imageOutput];
    
    
    //Preview Layer
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    UIView *myView = self.view;
    self.previewLayer.frame = myView.bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.cameraView.layer addSublayer:self.previewLayer];
    
    //Start capture session
    [self startCameraWithCompletionBlock:^{
        // Do sth if needed
    }];
}

- (void)startCameraWithCompletionBlock:(void (^)())completionBlock
{
    dispatch_async(dispatch_get_main_queue(), ^(){
        
        [self.captureSession startRunning];
        
        [UIView animateWithDuration:.3 animations:^{
            self.cameraView.alpha = 1;
        } completion:^(BOOL finished) {
            
            if (completionBlock) completionBlock();
        }];
    });
}

- (void)stopCameraWithCompletionBlock:(void (^)())completionBlock
{
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.captureSession stopRunning];
        
        [UIView animateWithDuration:.3 animations:^{
            self.cameraView.alpha = 0;
        } completion:^(BOOL finished) {
            
            if (completionBlock) completionBlock();
        }];
    });
}

- (AVCaptureDevice *)captureDeviceFront
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in devices) {
        if (device.position == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    
    return nil;
}

- (AVCaptureDevice *)captureDeviceBack
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in devices) {
        if (device.position == AVCaptureDevicePositionBack) {
            return device;
        }
    }
    
    return nil;
}

- (void)captureOutputImageWithCompletionBlock:(void (^)(UIImage *image))completionBlock
{
    AVCaptureConnection *captureConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:captureConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        UIImage *image = nil;
        
        if (imageDataSampleBuffer) {
            @autoreleasepool {
                NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                image = [[UIImage alloc] initWithData:imageData];
                
                
                // Image have right miror orientation when we took photo from front camera, so we need to raotat it again.
                UIImageOrientation orient = image.imageOrientation;
                CGImageRef imageRef = [image CGImage];
                
                if (self.frontCamera && orient == UIImageOrientationRight){
                    image = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:UIImageOrientationLeftMirrored];
                }
            }
        }
        
        if (completionBlock) completionBlock(image);
    }];
}


// MARK : - photo galery

- (void)getAllPhotosFromGallery
{
    // Fetch all assets, sorted by date created.
    PHFetchOptions *options = [PHFetchOptions new];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    self.imageManager = [PHCachingImageManager new];
}

// MARK: - CollectionView Delegate

- (void)initialImageGalleryCollection
{
    self.imageCollection.delegate = self;
    self.imageCollection.dataSource = self;
    self.imageCollection.backgroundColor = kCClear;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _assetsFetchResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Object
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    
    // Cell
    SFImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SFImagePickerCell" forIndexPath:indexPath];
    
    // Show the preview
    [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info)
     {
         cell.image.image = result;
     }];
    
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    
    [self.imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info)
     {
         // result is the actual image object.
         [self photoSelected:result];
     }];
}

// MARK: - Actions

- (IBAction)btnCloseSFImagePicker:(id)sender
{
    [self closeSFImagePicker];
}

- (IBAction)btnChangeCamera:(id)sender
{
    if (self.frontCamera) {
        // Turn to back camera
        self.frontCamera = NO;
        
        [self.btnChangeCamera setImage:[UIImage imageNamed:@"SFImagePickerFrontCamera"] forState:UIControlStateNormal];
    }
    else {
        // Turn to Front camera
        self.frontCamera = YES;
        
        [self.btnChangeCamera setImage:[UIImage imageNamed:@"SFImagePickerBackCamera"] forState:UIControlStateNormal];
    }
    
    [self stopCameraWithCompletionBlock:^{
        [self initCamera];
    }];
    
}

- (IBAction)btnCapturePhoto:(id)sender
{
    [self captureOutputImageWithCompletionBlock:^(UIImage *image) {
        [self photoSelected:image];
    }];
}

// MARK: - Helper

- (void)closeSFImagePicker
{
    [self stopCameraWithCompletionBlock:^{
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

// MARK: - Delegate

- (void)photoSelected:(UIImage *)image
{
    if ([self.delegate respondsToSelector:@selector(selectedPhoto:)]) {
        [self.delegate selectedPhoto:image];
    }
    
    [self closeSFImagePicker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
