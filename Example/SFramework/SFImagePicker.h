//
//  SFImagePicker.h
//  SFramework
//
//  Created by Sattar Falahati on 14/03/17.
//  Copyright © 2017 sattar_falahati. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SFImagePickerDelegate <NSObject>

- (void)selectedPhoto:(UIImage *)photo;

@end

@interface SFImagePicker : UIViewController

// Delegate
@property (weak, nonatomic) id<SFImagePickerDelegate> delegate;

// UI
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollection;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeCamera;

// Collection
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end


