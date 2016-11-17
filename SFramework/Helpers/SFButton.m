//
//  SFButton.m
//  Pods
//
//  Created by Mac on 11/11/16.
//
//

#import "SFButton.h"

// SFImporst ( to have access to all classes )
#import "SFImports.h"

@implementation UIButton (SFButton)

- (void)centerImageAndTitle
{
    // the space between the image and text
    CGFloat spacing = 6.0;
    
    // lower the text and push it left so it appears centered
    //  below the image
    CGSize imageSize = self.imageView.image.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    // raise the image and push it right so it appears centered
    //  above the text
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    self.imageEdgeInsets = UIEdgeInsetsMake( - (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    
    // increase the content height to avoid clipping
    CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2.0;
    self.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
    
}

- (void)setTitle:(NSString *)strTitle andTitleColor:(UIColor *)color forState:(UIControlState)state
{
    if ([strTitle isEmpty] || [color isEmpty] ) return;
    
    [self setTitleColor:color forState:state];
    [self setTitle:strTitle forState:state];
}

- (void)setImage:(UIImage *)btnImage withTransparentBackground:(BOOL)transparent forState:(UIControlState)state
{
    [self setTitle:@"" forState:state];
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [self setImage:btnImage forState:state];
    if(transparent){
        [self setBackgroundColor:kCClear];
    }
}

@end