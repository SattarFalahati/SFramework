//
//  SFImagePickerPreview.h
//  SFramework
//
//  Created by sattar.falahati on 06/07/17.
//  Copyright © 2017 sattar_falahati. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Image effects type
 */
typedef NS_ENUM(NSUInteger, SFImagePickerFilterType) {
    SFImagePickerFilterType_None = 0,
    SFImagePickerFilterType_GreyScale,
    SFImagePickerFilterType_Sepia,
    SFImagePickerFilterType_Blur,
    SFImagePickerFilterType_Clamp,
    SFImagePickerFilterType_Adjust,
    SFImagePickerFilterType_ToneCurve,
    SFImagePickerFilterType_Hot,
    SFImagePickerFilterType_Transfer,
    SFImagePickerFilterType_Edges
};


@interface SFImagePickerPreview : UIViewController

// Preview Dismiss handler
typedef void(^SFImagePickerPreviewDismissHandler)(UIImage *image, BOOL retake);
@property (strong, nonatomic) SFImagePickerPreviewDismissHandler dismissPreview;

// Data
@property (nonatomic, strong) UIImage *image;

// UI
@property (nonatomic, weak) IBOutlet UIImageView *img;

// Ui for control panel
@property (weak, nonatomic) IBOutlet UIView     *viewControlPanel;
@property (nonatomic, weak) IBOutlet UIButton   *btnRetake;
@property (nonatomic, weak) IBOutlet UIButton   *btnSave;
@property (nonatomic, weak) IBOutlet UIButton   *btnConfirm;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomViewControlPanel;

// UI For Edit
@property (weak, nonatomic) IBOutlet UIView           *viewEditPanel;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionFilters;
@property (nonatomic, weak) IBOutlet UIButton         *btnFilters;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightFilterCollection;

@end

@interface UIImage (SFImageExtend)

- (UIImage *)resizeImageWithResolution:(CGFloat)resolution;

@end
