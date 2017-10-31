//
//  SFImagePickerPreview.m
//  SFramework
//
//  Created by sattar.falahati on 06/07/17.
//  Copyright © 2017 sattar_falahati. All rights reserved.
//

#import "SFImagePickerPreview.h"

// CELL
#import "SFImagePickerFilterCollectionCell.h"

@interface SFImagePickerPreview () <UICollectionViewDelegate, UICollectionViewDataSource, SFImagePickerFilterDelegate>

@property (nonatomic) BOOL isFilterCollectionPresented;
@property (nonatomic) SFImagePickerFilterType selectedType;
@property (nonatomic) SFImagePickerFilterType lastSelectedType;

@property (nonatomic, strong) UIImage *imgOriginal;
@property (nonatomic, strong) UIImage *imgFilterd;
@property (nonatomic, strong) UIImage *imgFilterdGreyScale;;
@property (nonatomic, strong) UIImage *imgFilterdSpia;
@property (nonatomic, strong) UIImage *imgFilterdBlur;
@property (nonatomic, strong) UIImage *imgFilterdClamp;
@property (nonatomic, strong) UIImage *imgFilterdAdjust;
@property (nonatomic, strong) UIImage *imgFilterdToneCurve;
@property (nonatomic, strong) UIImage *imgFilterdHot;
@property (nonatomic, strong) UIImage *imgFilterdTransfer;
@property (nonatomic, strong) UIImage *imgFilterdEdges;

@end

@implementation SFImagePickerPreview

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Option
    _selectedType = SFImagePickerFilterType_None;
    
    // UI
    [self setupUI];
    [self initCollectionFilters];
}

// MARK: - UI

- (void)setupUI
{
    _constraintHeightFilterCollection.constant = 0;
    
    // Setup image
    self.img.image = self.image;
    self.imgOriginal = [UIImage imageWithCGImage:self.image.CGImage].copy;
    self.imgFilterd = [UIImage imageWithCGImage:self.image.CGImage].copy;
    
    // Setup buttons
    [_btnSave setImage:[UIImage imageNamed:@"SFImagePickerDownload"] forState:UIControlStateNormal];
    
    // Setup spinner
    [_spinner setHidesWhenStopped:YES];
    [_spinner stopAnimating];
    
    // Creat filters
    [self createFilters];
}

// MARK: - Create filters

- (void)createFilters
{
    UIImage *img = [self.imgOriginal.copy resizeImageWithResolution:300];
    
    _imgFilterdGreyScale = [self convertImage:img withType:SFImagePickerFilterType_GreyScale];
    _imgFilterdSpia = [self convertImage:img withType:SFImagePickerFilterType_Sepia];
    _imgFilterdBlur = [self convertImage:img withType:SFImagePickerFilterType_Blur];
    _imgFilterdClamp = [self convertImage:img withType:SFImagePickerFilterType_Clamp];
    _imgFilterdAdjust = [self convertImage:img withType:SFImagePickerFilterType_Adjust];
    _imgFilterdToneCurve = [self convertImage:img withType:SFImagePickerFilterType_ToneCurve];
    _imgFilterdHot = [self convertImage:img withType:SFImagePickerFilterType_Hot];
    _imgFilterdTransfer = [self convertImage:img withType:SFImagePickerFilterType_Transfer];
    _imgFilterdEdges = [self convertImage:img withType:SFImagePickerFilterType_Edges];
}

// MARK: - Collection view

- (void)initCollectionFilters
{
    _collectionFilters.delegate = self;
    _collectionFilters.dataSource = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SFImagePickerFilterCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SFImagePickerFilterCollectionCell" forIndexPath:indexPath];
    cell.delegate = self;
    
    BOOL selected = _selectedType == indexPath.row ? YES : NO;
    
    cell.imgSelected.hidden = !selected;
    cell.viewImgSelected.hidden = !selected;
    cell.type = indexPath.row;
    
    if (indexPath.row == 0) {
        cell.lblFilterType.text = @"Non";
        cell.image.image = self.image;
    }
    else if (indexPath.row == 1) {
        cell.lblFilterType.text = @"Moon";
        cell.image.image = _imgFilterdGreyScale;
    }
    else if (indexPath.row == 2) {
        cell.lblFilterType.text = @"Sepia";
        cell.image.image = _imgFilterdSpia;
    }
    else if (indexPath.row == 3) {
        cell.lblFilterType.text = @"Blur";
        cell.image.image = _imgFilterdBlur;
    }
    else if (indexPath.row == 4) {
        cell.lblFilterType.text = @"Color Clamp";
        cell.image.image = _imgFilterdClamp;
    }
    else if (indexPath.row == 5) {
        cell.lblFilterType.text = @"Adjust";
        cell.image.image = _imgFilterdAdjust;
    }
    else if (indexPath.row == 6) {
        cell.lblFilterType.text = @"Tone Curve";
        cell.image.image = _imgFilterdToneCurve;
    }
    else if (indexPath.row == 7) {
        cell.lblFilterType.text = @"Hot";
        cell.image.image = _imgFilterdHot;
    }
    else if (indexPath.row == 8) {
        cell.lblFilterType.text = @"Transfer";
        cell.image.image = _imgFilterdTransfer;
    }
    else if (indexPath.row == 9) {
        cell.lblFilterType.text = @"Edges";
        cell.image.image = _imgFilterdEdges;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

// MARK: - Filter delegate

- (void)filterdPhoto:(UIImage *)image withSelectedType:(SFImagePickerFilterType)type
{
    _selectedType = type;
    _imgFilterd = [[UIImage alloc] initWithCGImage:image.CGImage];
    
    [UIView transitionWithView:_img duration:.1f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        _img.image = _imgFilterd;
    } completion:^(BOOL finished) {
        
    }];
    
    [self.collectionFilters reloadData];
}

// MARK: - Actions

- (IBAction)selectorFilters:(id)sender
{
    _isFilterCollectionPresented = !_isFilterCollectionPresented;
    
    // Animate Collection view
    CGFloat bottom = _isFilterCollectionPresented ? -(_viewControlPanel.frame.size.height) : 0;
    _constraintBottomViewControlPanel.constant = bottom;
    
    CGFloat height = _isFilterCollectionPresented ? 150 : 0;
    _constraintHeightFilterCollection.constant = height;
    
    [UIView animateWithDuration:.3f animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        // Do sth if needed
    }];
    
    [UIView transitionWithView:_btnFilters duration:.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        NSString *strImage = _isFilterCollectionPresented ? @"SFImagePickerConfirm" : @"SFImagePickerFilters";
        [_btnFilters setImage:[UIImage imageNamed:strImage] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)selectorRetake:(id)sender
{
    if (self.dismissPreview) {
        self.dismissPreview(self.image, YES);
    }
}

- (IBAction)selectorSaveImage:(id)sender
{
    _btnSave.hidden = YES;
    [_spinner startAnimating];
    
    UIImageWriteToSavedPhotosAlbum(self.imgFilterd, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (IBAction)selectorConfirm:(id)sender
{
    if (self.dismissPreview) {
        self.dismissPreview(_imgFilterd, NO);
    }
}

// MARK: - Save image handler

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [_spinner stopAnimating];
    
    if (!error) {
        [_btnSave setUserInteractionEnabled:NO];
        [_btnSave setImage:[UIImage imageNamed:@"SFImagePickerDownloadDone"] forState:UIControlStateNormal];
        _btnSave.hidden = NO;
    }
}

// MARK: - FILTERS

- (UIImage *)convertImage:(UIImage *)imgOriginal withType:(SFImagePickerFilterType)type
{
    UIImage *newImage;
    @autoreleasepool
    {
        // Get Orientation
        UIImageOrientation orientation = imgOriginal.imageOrientation;
        
        // Create CI Image
        CIImage *img = [CIImage imageWithCGImage:imgOriginal.CGImage];
        
        // Create Context
        CIContext *context = [CIContext contextWithOptions:nil];
        
        // Create Filter and options
        CIFilter *filter = [self filterWithType:type];
        [filter setValue:img forKey:kCIInputImageKey];
        
        // Get Output image
        CIImage *outputImage = [filter outputImage];
        
        // Get image
        CGImageRef cgImg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        newImage = [UIImage imageWithCGImage:cgImg scale:1.0 orientation:orientation];
        
        // Release
        CGImageRelease(cgImg);
        context = nil;
    }
    return newImage;
}

// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIColorClamp

- (CIFilter *)filterWithType:(SFImagePickerFilterType)type
{
    // Create Filter and options
    if (type == SFImagePickerFilterType_Sepia) {
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
        NSNumber *scale = [NSNumber numberWithFloat:0.6];
        [filter setValue:scale forKey:@"inputIntensity"];
        return filter;
    }
    else if (type == SFImagePickerFilterType_GreyScale) {
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectNoir"];
        return filter;
    }
    else if (type == SFImagePickerFilterType_Blur) {
        CIFilter *filter = [CIFilter filterWithName:@"CIBoxBlur"];
        NSNumber *scale = [NSNumber numberWithFloat:50];
        [filter setValue:scale forKey:@"inputRadius"];
        return filter;
    }
    else if (type == SFImagePickerFilterType_Clamp) {
        CIFilter *filter = [CIFilter filterWithName:@"CIColorClamp"];
        CIVector *extentMin = [CIVector vectorWithX:-0.1 Y:-0.1 Z:-0.1 W:-0.1];
        CIVector *extentMax = [CIVector vectorWithX:0.7 Y:0.7 Z:0.7 W:0.7];
        [filter setValue:extentMin forKey:@"inputMinComponents"];
        [filter setValue:extentMax forKey:@"inputMaxComponents"];
        
        return filter;
    }
    else if (type == SFImagePickerFilterType_Adjust) {
        CIFilter *filter = [CIFilter filterWithName:@"CIExposureAdjust"];
        NSNumber *scale = [NSNumber numberWithFloat:0.99];
        [filter setValue:scale forKey:@"inputEV"];
        return filter;
    }
    else if (type == SFImagePickerFilterType_ToneCurve) {
        CIFilter *filter = [CIFilter filterWithName:@"CILinearToSRGBToneCurve"];
        return filter;
    }
    else if (type == SFImagePickerFilterType_Hot) {
        CIFilter *filter = [CIFilter filterWithName:@"CITemperatureAndTint"];
        CIVector *inputNeutral = [CIVector vectorWithX:6500 Y:500];
        CIVector *inputTargetNeutral = [CIVector vectorWithX:4000 Y:0];
        [filter setValue:inputNeutral forKey:@"inputNeutral"]; // Default value: [6500, 0] Identity: [6500, 0]
        [filter setValue:inputTargetNeutral forKey:@"inputTargetNeutral"]; // Default value: [6500, 0] Identity: [6500, 0]
        return filter;
    }
    else if (type == SFImagePickerFilterType_Transfer) {
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectTransfer"];
        return filter;
    }
    else if (type == SFImagePickerFilterType_Edges) {
        CIFilter *filter = [CIFilter filterWithName:@"CIEdges"]; // Default value: 1.0
        return filter;
    }
    return nil;
}


@end

@implementation UIImage (SFImageExtend)

- (UIImage *)resizeImageWithResolution:(CGFloat)resolution
{
    @autoreleasepool {
        
        CGFloat width = self.size.width;
        CGFloat height = self.size.height;
        CGRect  bounds = CGRectMake(0, 0, width, height);
        
        // Check if current image is not lower than size
        if (width <= resolution && height <= resolution) {
            return self;
        }
        
        CGFloat ratio = width / height;
        
        if (ratio > 1.0) {
            bounds.size.width = resolution;
            bounds.size.height = bounds.size.width / ratio;
        } else {
            bounds.size.height = resolution;
            bounds.size.width = bounds.size.height * ratio;
        }
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0.0);
        [self drawInRect:CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height)];
        
        UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return resizedImage;
    }
}

@end
