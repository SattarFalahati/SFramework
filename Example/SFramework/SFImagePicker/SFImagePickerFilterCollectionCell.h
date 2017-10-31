//
//  SFImagePickerFilterCollectionCell.h
//  SFramework
//
//  Created by sattar.falahati on 04/08/17.
//  Copyright © 2017 sattar_falahati. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SFImagePickerPreview.h"

@protocol SFImagePickerFilterDelegate <NSObject>

- (void)filterdPhoto:(UIImage *)image withSelectedType:(SFImagePickerFilterType)type;

@end

@interface SFImagePickerFilterCollectionCell : UICollectionViewCell

// Delegate
@property (nonatomic, strong) id<SFImagePickerFilterDelegate> delegate;

// UI
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel     *lblFilterType;
@property (weak, nonatomic) IBOutlet UIImageView *imgSelected;
@property (weak, nonatomic) IBOutlet UIView *viewImgSelected;
@property (nonatomic) SFImagePickerFilterType type;

@end
