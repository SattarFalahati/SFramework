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
 * This method will add trailing, leading, bottom, top constraints to the view and make the equal to item
 */
- (void)setConstraintsEqualToItem:(id)item;

// MARK: - Autolayouts

/// SFConstraint Completion Block
typedef void (^SFConstraintCompletionBlock)();

/// Get constraint of a view
- (NSLayoutConstraint *)constraintWithAttribute:(NSLayoutAttribute)attribute;

/// Setter method to set or change calue of a constraint
- (void)setConstraintValue:(CGFloat)value withAttribute:(NSLayoutAttribute)attribute;

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

// MARK: - Autolayout Setter with animation

- (void)setConstraintHeight:(CGFloat)constraintHeight animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock;
- (void)setConstraintWidth:(CGFloat)constraintWidth animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock;
- (void)setConstraintTop:(CGFloat)constraintTop animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock;
- (void)setConstraintBottom:(CGFloat)constraintBottom animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock;
- (void)setConstraintLeft:(CGFloat)constraintLeft animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock;
- (void)setConstraintRight:(CGFloat)constraintRight animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock;
- (void)setConstraintLeading:(CGFloat)constraintLeading animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock;
- (void)setConstraintTrailing:(CGFloat)constraintTrailing animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock;
- (void)setConstraintCentrX:(CGFloat)constraintCentrX animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock;
- (void)setConstraintCentrY:(CGFloat)constraintCentrY animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock;

@end
