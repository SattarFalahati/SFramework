//
//  SFConstraints.h
//  Pods
//
//  Created by Sattar Falahati on 11/05/17.
//
//

#import <UIKit/UIKit.h>

@interface UIView (SFConstraints)

/**
 *  Set constraints of a view equal to another view
 *
 * This method will add trailing, leading, bottom, top constraints to the view and make the equal to @param item
 */
- (void)setConstraintsEqualToItem:(id)item;

// MARK: - Autolayouts

@property (nonatomic) CGFloat constraintHeight;
@property (nonatomic) CGFloat constraintWidth;

@property (nonatomic) CGFloat constraintTop;
@property (nonatomic) CGFloat constraintBottom;
@property (nonatomic) CGFloat constraintLeft;
@property (nonatomic) CGFloat constraintRight;
@property (nonatomic) CGFloat constraintLeading;
@property (nonatomic) CGFloat constraintTrailing;

@property (nonatomic) CGFloat constraintCentrX;
@property (nonatomic) CGFloat constraintCentrY;


@end
