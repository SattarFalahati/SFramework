//
//  SFImagePickerFilterCollectionCell.m
//  SFramework
//
//  Created by sattar.falahati on 04/08/17.
//  Copyright © 2017 sattar_falahati. All rights reserved.
//

#import "SFImagePickerFilterCollectionCell.h"

@interface SFImagePickerFilterCollectionCell ()

@property (nonatomic) BOOL isAlreadySelected;
@property (nonatomic, strong) UIImage *selectedImage;

@end

@implementation SFImagePickerFilterCollectionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Image
    [_image.layer setCornerRadius:2.0f];
    _image.layer.masksToBounds = YES;
    CGFloat radius = fmin(_viewImgSelected.frame.size.height , _viewImgSelected.frame.size.width);
    [_viewImgSelected.layer setCornerRadius:(radius/2.0)];
}

// MARK: - ACTION

- (IBAction)selectorFilter:(id)sender
{
    _selectedImage = _image.image;
    
    if ([self.delegate respondsToSelector:@selector(filterdPhoto:withSelectedType:)]) {
        [self.delegate filterdPhoto:_selectedImage withSelectedType:_type];
    }
}

@end
