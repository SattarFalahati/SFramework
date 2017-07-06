//
//  SFImagePickerPreview.m
//  SFramework
//
//  Created by sattar.falahati on 06/07/17.
//  Copyright © 2017 sattar_falahati. All rights reserved.
//

#import "SFImagePickerPreview.h"

@interface SFImagePickerPreview ()

@end

@implementation SFImagePickerPreview

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UI
    [self setupUI];
}

// MARK: - UI

- (void)setupUI
{
    // Setup image
    self.img.image = self.image;
    
    // Setup buttons
    [_btnSave setImage:[UIImage imageNamed:@"SFImagePickerDownload"] forState:UIControlStateNormal];
    
    // Setup spinner
    [_spinner setHidesWhenStopped:YES];
    [_spinner stopAnimating];
}

// MARK: - Actions

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
    
    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (IBAction)selectorConfirm:(id)sender
{
    if (self.dismissPreview) {
        self.dismissPreview(self.image, NO);
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

@end
