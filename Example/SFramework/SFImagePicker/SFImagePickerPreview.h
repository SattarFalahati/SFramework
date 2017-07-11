//
//  SFImagePickerPreview.h
//  SFramework
//
//  Created by sattar.falahati on 06/07/17.
//  Copyright © 2017 sattar_falahati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFImagePickerPreview : UIViewController

// Preview Dismiss handler
typedef void(^SFImagePickerPreviewDismissHandler)(UIImage *image, BOOL retake);
@property (strong, nonatomic) SFImagePickerPreviewDismissHandler dismissPreview;

// Data
@property (nonatomic, strong) UIImage *image;

// UI
@property (nonatomic, weak) IBOutlet UIImageView *img;
@property (nonatomic, weak) IBOutlet UIButton   *btnRetake;
@property (nonatomic, weak) IBOutlet UIButton   *btnSave;
@property (nonatomic, weak) IBOutlet UIButton   *btnConfirm;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;

// UI For Edit
@property (nonatomic, weak) IBOutlet UICollectionView *collectionFilters;
@property (nonatomic, weak) IBOutlet UIButton         *btnFilters;

@end
