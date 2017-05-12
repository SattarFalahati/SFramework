//
//  SFInAppNotification.m
//  Pods
//
//  Created by Sattar Falahati on 13/02/17.
//
//

#import "SFInAppNotification.h"

#import "SFImports.h"

@interface SFInAppNotification()

// MARK: - Default elements

/// Set tag for SFInAppNotification view to check if view is presented.
#define KSFInAppNotificationTag     319489485

/// Defualt style
#define KDefaultBackgroundColor         RGBA(0, 0, 0, .8)
#define KDefaultTitleFont               [UIFont boldSystemFontOfSize:16]
#define KDefaultSubtitleFont            [UIFont systemFontOfSize:14]

/// Maximum acceptable characters
#define KTitleMaximumAcceptableCharacters           80
#define KSubtitleMaximumAcceptableCharacters        150

// MARK: - Properties

/// Swipe Gesture (direction UP) handler
@property (nonatomic, copy) SFInAppNotificationSwipeHandler swipeHandler;

/// Tap Gesture handler
@property (nonatomic, copy) SFInAppNotificationTapHandler tapHandler;

/// Dissmiss handler
@property (nonatomic, copy) SFInAppNotificationDismissHandler dismissHandler;

/// Constraint to hold the height of a view
@property (nonatomic, weak) NSLayoutConstraint *constraintHeight;

/// Constraint height size to hold the size of constraint
@property (nonatomic) CGFloat constraintHeightSize;

/// Dismiss timer
@property (nonatomic, strong) NSTimer *dismissalTimer;

/// Pan handler statuse cancel ( use when user decide to not swipe the view and read it again )
@property (nonatomic) BOOL swipeStatuseIsCancel;

/// To check if notification present an image or not
@property (nonatomic) BOOL inAppNotificationWithImage;

@end

@implementation SFInAppNotification

- (void)dealloc
{
    _swipeHandler = nil;
    _tapHandler = nil;
    _dismissHandler = nil;
    _constraintHeight = nil;
    _dismissalTimer = nil;
}

// MARK: - Instantiate

/// Initial notification view with title, subtitle, image
- (instancetype)initSFInAppNotificationWithTitle:(NSString *)strTitle withSubtitle:(NSString *)strSubtitle withImage:(UIImage *)image
{
    if (self == [super init]) {
        
        // Initial self
        [self initSFInAppNotificationView];
        
        // Initial view elements (At the begining all styles are default style)
        [self initElements];
        
        /// It work based on Image, if there is no image just show the lbls else show lbls with image
        if (image == nil) {
            self.inAppNotificationWithImage = NO;
            
            // Initial lables
            [self initLabelsWithTitleString:strTitle andSubtitleString:strSubtitle];
        }
        else {
            self.inAppNotificationWithImage = YES;
            
            // Full versione (with image and lbls)
            [self initImageWithImage:image andLabelsWithTitleString:strTitle andSubtitleString:strSubtitle];
        }
    }
    return self;
}


/// Main initialization
+ (instancetype)showSFInAppNotificationOnView:(UIView *)view withTitle:(NSString *)strTitle withSubtitle:(NSString *)strSubtitle withImage:(UIImage *)image withDismissalDuration:(NSTimeInterval)dismissalDuration withDelegate:(id<SFInAppNotificationDelegate>)delagate withTapHandler:(SFInAppNotificationTapHandler)tap withSwipeHandler:(SFInAppNotificationSwipeHandler)swipe withDismissHandler:(SFInAppNotificationDismissHandler)dismiss
{
    // Hide it first if it's showing
    [self hideSFInAppNotificationFromView:view];
    
    // Basic initialization notification view
    SFInAppNotification *notification = [[SFInAppNotification alloc] initSFInAppNotificationWithTitle:strTitle withSubtitle:strSubtitle withImage:image];
    
    // Set delegate
    notification.delegate = delagate;
    
    // Set tag
    notification.tag = KSFInAppNotificationTag;
    
    // Tap Handler
    if (tap) {
        notification.tapHandler = tap;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:notification action:@selector(tapHandler:)];
        [tap setNumberOfTapsRequired:1];
        [notification addGestureRecognizer:tap];
    }
    
    // Swipe Handler
    if (swipe) {
        notification.swipeHandler = swipe;
        
        // Use PAN instead of SWIPE gesture to handle touch longer than swipe
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:notification action:@selector(swipeHandler:)];
        [notification addGestureRecognizer:panRecognizer]; // add to the view you want to detect swipe on
        notification.swipeStatuseIsCancel = YES;
        
    }
    
    // Dismiss Handler
    if (dismiss) {
        notification.dismissHandler = dismiss;
    }
    
    // Set timer
    if (dismissalDuration > 0) {
        notification.dismissalTimer = [NSTimer scheduledTimerWithTimeInterval:dismissalDuration target:notification selector:@selector(dismissViewHandler:) userInfo:view repeats:NO];
    }
    
    // set hidden befor showing
    [notification setAlpha:0.0];
    
    // DELEGATE will appear
    [notification notifcationWillAppear];
    
    // Add notificayion to subview
    [view addSubview:notification];
    
    // show with animation
    [UIView animateWithDuration:0.2 animations:^{
        notification.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        // DELEGATE Did appear
        [notification notifcationDidAppear];
        
    }];
    
    return notification;
}

/// Hide notification view

+ (void)hideSFInAppNotificationFromView:(UIView *)view
{
    UIView *notificationView = [self getSFInAppNotificationForView:view];
    
    if (notificationView != nil) {
        
        [UIView animateWithDuration:0.2 animations:^{
            notificationView.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            [notificationView removeFromSuperview];
            
        }];
    }
}

// MARK: - Configuration

/// This method will initial the view and will add necessary constraints to the notification view
- (void)initSFInAppNotificationView
{
    /// Primery settings
    
    // Mandatory to disable old way of positioning
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self setUserInteractionEnabled:YES];
    
    /// Set view default appearance
    [self setSFInAppNotificationBackGroundColor:KDefaultBackgroundColor];
    
    /// Set notification view cnostraints
    // Width constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute: NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    /*
     ** Height constraint
     ** EXPLNATION : set the height to 100 for the begining then after that height becom calculated we can update it
     */
    self.constraintHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    
    // Add created constraint to the notification view
    [self addConstraint:self.constraintHeight];
}

/// This method will initial all the elements that are going to be visible inside the notification view
- (void)initElements
{
    /// Create Image (left image)
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 70, 70)];
    [self.img setContentMode:UIViewContentModeScaleAspectFill];
    
    // Mandatory to disable old way of positioning
    self.img.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Make image circular
    [self.img makeViewCircular];
    
    /// Create lbl Title
    // Initialitze the UILabel
    self.lblTitle = [UILabel new];
    
    // Set default font and color
    [self setTitleFont:KDefaultTitleFont andColor:kCWhite];
    
    // Mandatory to disable old way of positioning
    self.lblTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Mandatory to allow multiline behaviour
    self.lblTitle.numberOfLines = 0;
    
    /// Adding subtitle label to view
    // Initialitze the UILabel
    self.lblSubtitle = [[UILabel alloc] init];
    
    // Set default font and color
    [self setSubtitleFont:KDefaultSubtitleFont andColor:kCWhite];
    
    // Mandatory to disable old way of positioning
    self.lblSubtitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Mandatory to allow multiline behaviour
    self.lblSubtitle.numberOfLines = 0;
}

/// Use this method when there is no image
- (void)initLabelsWithTitleString:(NSString *)strTitle andSubtitleString:(NSString *)strSubtitle
{
    /// LBL TITLE
    // Set text
    NSString *title = [self prepareTitleMaximumAcceptableCharactersForString:strTitle];
    [self.lblTitle setText:title];
    
    // Add subview to the parent view
    [self addSubview:self.lblTitle];
    
    // Horizontal constraint
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[label]-(20)-|" options:0 metrics:nil views:@{@"label":self.lblTitle}]];
    
    // Vertical constraint
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(30)-[label]" options:0 metrics:nil views:@{@"label":self.lblTitle}]];
    
    /// LBL SUBTITLE
    // Set text
    NSString *subtitle = [self prepareSubitleMaximumAcceptableCharactersForString:strSubtitle];
    [self.lblSubtitle setText:subtitle];
    
    // Add subview to the parent view
    [self addSubview:self.lblSubtitle];
    
    // Horizontal constraint
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[label]-(20)-|" options:0 metrics:nil views:@{@"label":self.lblSubtitle,@"boton":self}]];
    
    // Vertical constraint
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previous]-(10)-[label]" options:0 metrics:nil views:@{@"label":self.lblSubtitle,@"previous":self.lblTitle}]];
    
    // Refresh layouts
    [self layoutIfNeeded];
    
    /// RESET VIEW HEIGHT
    [self resetViewHeight];
}

/// Use this method when image must be visible
- (void)initImageWithImage:(UIImage *)img andLabelsWithTitleString:(NSString *)strTitle andSubtitleString:(NSString *)strSubtitle
{
    /// IMAGE
    // Set image
    [self.img setImage:img];
    
    // Add subview to the parent view
    [self addSubview:self.img];
    
    /// set constraints for image (primery)
    // CenterY constraint For Image
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.img attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute: NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    // Image width
    [self.img addConstraint:[NSLayoutConstraint constraintWithItem:self.img attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute: NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70]];
    
    // Image height
    [self.img addConstraint: [NSLayoutConstraint constraintWithItem:self.img attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70]];
    
    /// LBL TITLE
    // Set text
    NSString *title = [self prepareTitleMaximumAcceptableCharactersForString:strTitle];
    [self.lblTitle setText:title];
    
    // Add subview to the parent view
    [self addSubview:self.lblTitle];
    
    /// LBL SUBTITLE
    // Set text
    NSString *subtitle = [self prepareSubitleMaximumAcceptableCharactersForString:strSubtitle];
    [self.lblSubtitle setText:subtitle];
    
    // Add subview to the parent view
    [self addSubview:self.lblSubtitle];
    
    /// SET CONSTRAINT
    // Horizontal constraint for lbl title
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[img]-(10)-[label]-(10)-|" options:0 metrics:nil views:@{@"img":self.img, @"label":self.lblTitle}]];
    
    // Vertical constraint for lbl title
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(30)-[label]" options:0 metrics:nil views:@{@"label":self.lblTitle}]];
    
    // Horizontal constraint for lbl subtitle
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[img]-(10)-[label]-(10)-|" options:0 metrics:nil views:@{@"img":self.img, @"label":self.lblSubtitle}]];
    
    // Vertical constraint for lbl subtitle
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lblTitle]-(10)-[label]" options:0 metrics:nil views:@{@"label":self.lblSubtitle,@"lblTitle":self.lblTitle}]];
    
    // Refresh layouts
    [self layoutIfNeeded];
    
    /// RESET VIEW HEIGHT
    [self resetViewHeight];
}


/// RESET the height of the notification constraint
- (void)resetViewHeight
{
    // Calculate the height
    CGFloat lblTitleheight = self.lblTitle.frame.size.height;
    CGFloat lblSubtitleheight = self.lblSubtitle.frame.size.height;
    
    CGFloat totalHeight;
    
    if (self.inAppNotificationWithImage) {
        totalHeight = 30 + lblTitleheight + 10 + lblSubtitleheight + 20;
    }
    else {
        totalHeight = 30 + lblTitleheight + 10 + lblSubtitleheight + 0;
    }
    
    if (totalHeight > 110.0) {
        self.constraintHeightSize = totalHeight;
    }
    else {
        self.constraintHeightSize = 110;
    }
    
    self.constraintHeight.constant = self.constraintHeightSize;
    
    [self layoutIfNeeded];
}

// MARK: - Handlers

/// Manage dismiss handler
- (void)dismissViewHandler:(NSTimer *)sender
{
    // Get view that SFInAppNotification been presented on that
    UIView *view = (UIView *) sender.userInfo;
    
    // Kill timer
    [self destroyTimer];
    
    // DELEGATE Will dissmis
    [self notifcationWillDismiss];
    
    // Dismiss the handler
    [SFInAppNotification hideSFInAppNotificationFromView:view];
    
    if (self.dismissHandler) self.dismissHandler();
    
    // DELEGATE Did dissmis
    [self notifcationDidDismiss];
}

/// Manage tap handler
- (void)tapHandler:(UITapGestureRecognizer *)recognizer
{
    // Kill timer
    [self destroyTimer];
    
    // DELEGATE Will dissmis
    [self notifcationWillDismiss];
    
    // Dismiss the handler
    [SFInAppNotification hideSFInAppNotificationFromView:recognizer.view];
    
    if (self.tapHandler) self.tapHandler();
    if (self.dismissHandler) self.dismissHandler();
    
    // DELEGATE Did dissmis
    [self notifcationDidDismiss];
}

/// Manage swipe handler
- (void)swipeHandler:(UIPanGestureRecognizer *)recognizer
{
    // Kill timer
    [self destroyTimer];
    
    CGPoint startLocation;
    CGPoint stopLocation;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        startLocation = [recognizer locationInView:self];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint distance = [recognizer translationInView:self];
        //        NSLog(@"distance.y - %f", distance.y);
        if (distance.y >= 1) {
            self.swipeStatuseIsCancel = NO;
            return;
        }
        else {
            self.swipeStatuseIsCancel = YES;
        }
        [UIView animateWithDuration:0.1 animations:^{
            
            [self setFrame: CGRectMake(0, distance.y, SCREEN_WIDTH, self.frame.size.height)];
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (self.swipeStatuseIsCancel == NO) return;
        
        // DELEGATE Will dissmis
        [self notifcationWillDismiss];
        
        stopLocation = [recognizer locationInView:self];
        CGFloat distanceHeight = stopLocation.y - startLocation.y;
        //        NSLog(@"Distance: %f", distanceHeight);
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self setFrame: CGRectMake(0, -distanceHeight, SCREEN_WIDTH, self.frame.size.height)];
            
            self.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            // Hide notification view
            [SFInAppNotification hideSFInAppNotificationFromView:recognizer.view];
            
            if (self.swipeHandler) self.swipeHandler();
            if (self.dismissHandler) self.dismissHandler();
            
            // DELEGATE Did dissmis
            [self notifcationDidDismiss];
            
        }];
    }
}

// MARK: - Appearance

- (void)setSFInAppNotificationBackGroundColor:(UIColor*)color
{
    [self setBackgroundColor:color];
}

- (void)setTitleFont:(UIFont*)font andColor:(UIColor*)color
{
    [self.lblTitle setFont:font];
    [self.lblTitle setTextColor:color];
}

- (void)setSubtitleFont:(UIFont*)font andColor:(UIColor*)color
{
    [self.lblSubtitle setFont:font];
    [self.lblSubtitle setTextColor:color];
}

// MARK: - Private helpers

/// Get notification view if it is presenting
+ (id)getSFInAppNotificationForView:(UIView *)view
{
    id subView = [view viewWithTag:KSFInAppNotificationTag];
    
    if (subView) {
        return subView;
    }
    return nil;
}

/// Kill the timer
- (void)destroyTimer
{
    /// Check if timer is working disable it
    if ([self.dismissalTimer isValid]) {
        // Stop Timer
        [self.dismissalTimer invalidate];
        self.dismissalTimer = nil;
    }
}

/// Check for Maximum acceptable characters
- (NSString *)prepareTitleMaximumAcceptableCharactersForString:(NSString *)strTitle
{
    if ([strTitle isEmptyString]) return @"Title";
    
    NSString *strFinal;
    
    NSInteger characters = [strTitle length];
    if (characters > KTitleMaximumAcceptableCharacters) {
        strTitle = [strTitle safeSubstringToIndex:KTitleMaximumAcceptableCharacters];
        strFinal =  [strTitle stringByAppendingString:@" ..."];
    }
    else {
        strFinal = strTitle;
    }
    return strFinal;
}

/// Check for Maximum acceptable characters
- (NSString *)prepareSubitleMaximumAcceptableCharactersForString:(NSString *)strSubtitle
{
    if ([strSubtitle isEmptyString]) return @"Subtitle";
    
    NSString *strFinal;
    
    NSInteger characters = [strSubtitle length];
    if (characters > KSubtitleMaximumAcceptableCharacters) {
        strSubtitle = [strSubtitle safeSubstringToIndex:KSubtitleMaximumAcceptableCharacters];
        strFinal =  [strSubtitle stringByAppendingString:@" ..."];
    }
    else {
        strFinal = strSubtitle;
    }
    return strFinal;
}

// MARK: - Delegate methods

- (void)notifcationWillAppear
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SFInAppNotificationWillAppear:)]) {
        [self.delegate SFInAppNotificationWillAppear:self];
    }
}

- (void)notifcationDidAppear
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SFInAppNotificationDidAppear:)]) {
        [self.delegate SFInAppNotificationDidAppear:self];
    }
}

- (void)notifcationWillDismiss
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SFInAppNotificationWillDisimiss:)]) {
        [self.delegate SFInAppNotificationWillDisimiss:self];
    }
}

- (void)notifcationDidDismiss
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SFInAppNotificationDidDismiss:)]) {
        [self.delegate SFInAppNotificationDidDismiss:self];
    }
}



@end
