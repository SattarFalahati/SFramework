//
//  SFInAppNotification.h
//  Pods
//
//  Created by Sattar Falahati on 13/02/17.
//
//

#import <UIKit/UIKit.h>


/// Delagate
@protocol SFInAppNotificationDelegate;

// MARK: - Handler Blocks

/// Handler for TAP on SFInAppNotification view
typedef void (^SFInAppNotificationTapHandler)(void);

/// Handler for SWIPE on SFInAppNotification view
typedef void (^SFInAppNotificationSwipeHandler)(void);

/// Handler for Dissmiss on delay for SFInAppNotification view
typedef void (^SFInAppNotificationDismissHandler)(void);

@interface SFInAppNotification : UIView

// MARK: - Properties

/// Lbl title to hold title string
@property (nonatomic, strong) UILabel *lblTitle;

/// Lbl subtitle to hold subtitle string
@property (nonatomic, strong) UILabel *lblSubtitle;

/// Img to hold image
@property (nonatomic, strong) UIImageView *img;


// MARK: - Instantiate

/**
 * Main method to instantiate a notification view and set the desired title, subtitle, image, dismissalDuration, Delegate and handlers.
 *  @param view => The view that NotificationView will presented on that.
 *  @param strTitle & strSubtitle => Desired title and subtitle will becom presented in notification view
 *  @param image => Desired image to show in notification view, in case it sent nil notification view will presented without image.
 *  @param dismissalDuration => Desired duration (time) to show the notification view, in case it sent 0 notification view will not getting dissmis automatically
 *  @param delagate => use delegate to handel SFInAppNotificationDelegate
 *  @param tap => this is a handler for when user taping (selecting) the notification view it will getting call
 *  @param swipe => this is a handler for when user swiping the notification view it will getting call
 *  @param dismiss => this is a handler for when notification view is getting dismiss and it will getting call A) after swipe B) after tap C) after dismiss view by timer
 *  @return => SFInAppNotification to handel the styles like setting text or background color
 */
+ (instancetype)showSFInAppNotificationOnView:(UIView *)view withTitle:(NSString *)strTitle withSubtitle:(NSString *)strSubtitle withImage:(UIImage *)image withDismissalDuration:(NSTimeInterval)dismissalDuration withDelegate:(id<SFInAppNotificationDelegate>)delagate withTapHandler:(SFInAppNotificationTapHandler)tap withSwipeHandler:(SFInAppNotificationSwipeHandler)swipe withDismissHandler:(SFInAppNotificationDismissHandler)dismiss;

/**
 * Hide (dismiss) the notification view from view
 *  @param view => The view that NotificationView did present on that.
 */
+ (void)hideSFInAppNotificationFromView:(UIView *)view;

// MARK: - Appearance

/// Set notification view background color
- (void)setSFInAppNotificationBackGroundColor:(UIColor*)color;

/// Set font and color for title
- (void)setTitleFont:(UIFont*)font andColor:(UIColor*)color;

/// Set font and color for subtitle
- (void)setSubtitleFont:(UIFont*)font andColor:(UIColor*)color;

/// The SFInAppNotificationDelegate
@property (nonatomic, weak) id<SFInAppNotificationDelegate> delegate;

@end

// MARK: - Delegates

@protocol SFInAppNotificationDelegate <NSObject>

@optional

/// Call before SFInAppNotification did load
- (void)SFInAppNotificationWillAppear:(SFInAppNotification *)notification;

/// Call after SFInAppNotification did load
- (void)SFInAppNotificationDidAppear:(SFInAppNotification *)notification;

/// Call before SFInAppNotification disappear
- (void)SFInAppNotificationWillDisimiss:(SFInAppNotification *)notification;

/// Call after SFInAppNotification disappear
- (void)SFInAppNotificationDidDismiss:(SFInAppNotification *)notification;

@end

