//
//  SFImagePicker.h
//  SFramework
//
//  Created by Sattar Falahati on 14/03/17.
//  Copyright © 2017 sattar_falahati. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 
 * A class to use Camera and gallery of the phone 
 * To implement and make this class working :
 * A) Copy SFImagePicker.h/m , SFImagePickerCell.h/m and ImagePicker.storyboard to your project
 * B) You can change icons but if you want to use icons copy the SFImagePicker folder from Images.cxassets
 * C) Don't Forget about Plist and add this lines :
    <key>NSCameraUsageDescription</key>
	<string>Your description</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>Your description</string>
 * @param : Delegate (you need to set delegate to get selected photo)
 * @param : Option to chose between front and back camera
 * @return : Selected photo in delegate
**/

/// Options (front/back) Camera
typedef NS_ENUM(NSUInteger, SFImagePickerCameraOption) {
    SFImagePickerCameraFront = 1,
    SFImagePickerCameraBack
};

@protocol SFImagePickerDelegate <NSObject>

- (void)selectedPhoto:(UIImage *)photo;

@end

@interface SFImagePicker : UIViewController

// Delegate
@property (weak, nonatomic) id<SFImagePickerDelegate> delegate;

// Option
@property (nonatomic) SFImagePickerCameraOption option;
@property (nonatomic) BOOL showPreview;

// UI
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollection;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeCamera;
@property (weak, nonatomic) IBOutlet UIButton *btnResize;
// Container
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

// Auto layout
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHaight;

// Collection
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end


