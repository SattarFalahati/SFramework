//
//  SFConstraints.m
//  Pods
//
//  Created by Sattar Falahati on 11/05/17.
//
//

#import "SFConstraints.h"

@implementation UIView (SFConstraints)


- (void)setConstraintsEqualToItem:(id)item;
{
    //Trailing
    NSLayoutConstraint *trailing =[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.f];
    
    //Leading
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.f];
    
    //Bottom
    NSLayoutConstraint *bottom =[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.f];
    
    //Top
    NSLayoutConstraint *top =[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.f];
    
    [NSLayoutConstraint activateConstraints:@[trailing, leading, bottom, top]];
}


// MARK: - Helper methods

/// Get constraint of a view
- (NSLayoutConstraint *)constraintWithAttribute:(NSLayoutAttribute)attribute
{
    // Create array to put all constraints that we find in it
    NSMutableArray *arrFoundConstraints = [NSMutableArray array];
    
    // Define that constraint is added to first or second element
    BOOL isFirstElement = (attribute != NSLayoutAttributeTrailing && attribute != NSLayoutAttributeBottom);
    
    // Get all constraints from super views
    NSArray *constraints = [NSArray arrayWithArray:self.constraints];
    constraints = [constraints arrayByAddingObjectsFromArray:self.superview.constraints];
    
    
    // Get singele constraint in array of constraints
    for (NSLayoutConstraint *constraint in constraints) {
        
        // make sure that is a VALID constraint
        if (!constraint.isActive) continue;
        if (![constraint isMemberOfClass:[NSLayoutConstraint class]]) continue;
        
        if (isFirstElement) {
            if (constraint.firstAttribute != attribute) continue;
        }
        else {
            if (constraint.secondAttribute != attribute) continue;
        }
        
        if (constraint.firstItem != self && constraint.secondItem != self) continue;
        
        if (arrFoundConstraints) {
            // Found first constraint
            [arrFoundConstraints addObject:constraint];
        }
        else {
            // Found another constraint
            // Sort them by priority
            NSLayoutConstraint *firstConstraint = arrFoundConstraints.firstObject;
            if (constraint.priority > firstConstraint.priority) {
                // Constraint have higher priority
                [arrFoundConstraints insertObject:constraint atIndex:0];
            }
            else {
                // Constraint have lower priority
                [arrFoundConstraints addObject:constraint];
            }
        }
    }
    
    return arrFoundConstraints.firstObject;
}

/// Setter method to set or change calue of a constraint
- (void)setConstraintValue:(CGFloat)value withAttribute:(NSLayoutAttribute)attribute
{
    NSLayoutConstraint *constraint = [self constraintWithAttribute:attribute];
    
    if (constraint) {
        constraint.constant = value;
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

- (void)setConstraintValue:(CGFloat)value withAttribute:(NSLayoutAttribute)attribute animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock
{
    NSLayoutConstraint *constraint = [self constraintWithAttribute:attribute];
    
    if (constraint) {
        constraint.constant = value;
        
        [UIView animateWithDuration:duration animations:^{
            
            [[self superview] setNeedsUpdateConstraints];
            [[self superview] updateConstraintsIfNeeded];
            [[self superview] setNeedsLayout];
            [[self superview] layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            if (compilationBlock) compilationBlock();
        }];
    }
}

// MARK: - Autolayout Getter

- (CGFloat)constraintHeight
{
    return [self constraintWithAttribute:NSLayoutAttributeHeight].constant;
}

- (CGFloat)constraintWidth
{
    return [self constraintWithAttribute:NSLayoutAttributeWidth].constant;
}

- (CGFloat)constraintTop
{
    return [self constraintWithAttribute:NSLayoutAttributeTop].constant;
}

- (CGFloat)constraintBottom
{
    return [self constraintWithAttribute:NSLayoutAttributeBottom].constant;
}

- (CGFloat)constraintLeft
{
    return self.constraintLeading;
}

- (CGFloat)constraintRight
{
    return self.constraintTrailing;
}

- (CGFloat)constraintLeading
{
    return [self constraintWithAttribute:NSLayoutAttributeLeading].constant;
}

- (CGFloat)constraintTrailing
{
    return [self constraintWithAttribute:NSLayoutAttributeTrailing].constant;
}

- (CGFloat)constraintCentrX
{
    return [self constraintWithAttribute:NSLayoutAttributeCenterX].constant;
}

- (CGFloat)constraintCentrY
{
    return [self constraintWithAttribute:NSLayoutAttributeCenterY].constant;
}


// MARK: - Autolayout Setter

- (void)setConstraintHeight:(CGFloat)constraintHeight
{
    [self setConstraintValue:constraintHeight withAttribute:NSLayoutAttributeHeight];
}

- (void)setConstraintWidth:(CGFloat)constraintWidth
{
    [self setConstraintValue:constraintWidth withAttribute:NSLayoutAttributeWidth];
}

- (void)setConstraintTop:(CGFloat)constraintTop
{
    [self setConstraintValue:constraintTop withAttribute:NSLayoutAttributeTop];
}

- (void)setConstraintBottom:(CGFloat)constraintBottom
{
    [self setConstraintValue:constraintBottom withAttribute:NSLayoutAttributeBottom];
}

- (void)setConstraintLeft:(CGFloat)constraintLeft
{
    self.constraintLeading = constraintLeft;
}

- (void)setConstraintRight:(CGFloat)constraintRight
{
    self.constraintTrailing = constraintRight;
}

- (void)setConstraintLeading:(CGFloat)constraintLeading
{
    [self setConstraintValue:constraintLeading withAttribute:NSLayoutAttributeLeading];
}

- (void)setConstraintTrailing:(CGFloat)constraintTrailing
{
    [self setConstraintValue:constraintTrailing withAttribute:NSLayoutAttributeTrailing];
}

- (void)setConstraintCentrX:(CGFloat)constraintCentrX
{
    [self setConstraintValue:constraintCentrX withAttribute:NSLayoutAttributeCenterX];
}

- (void)setConstraintCentrY:(CGFloat)constraintCentrY
{
    [self setConstraintValue:constraintCentrY withAttribute:NSLayoutAttributeCenterY];
}

// MARK: - Autolayout Setter with animation

- (void)setConstraintHeight:(CGFloat)constraintHeight animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock
{
    [self setConstraintValue:constraintHeight withAttribute:NSLayoutAttributeHeight animatedWithDuration:duration withCompletionBlock:^{
        if (compilationBlock) compilationBlock();
    }];
}

- (void)setConstraintWidth:(CGFloat)constraintWidth animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock
{
    [self setConstraintValue:constraintWidth withAttribute:NSLayoutAttributeWidth animatedWithDuration:duration withCompletionBlock:^{
        if (compilationBlock) compilationBlock();
    }];
}

- (void)setConstraintTop:(CGFloat)constraintTop animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock
{
    [self setConstraintValue:constraintTop withAttribute:NSLayoutAttributeTop animatedWithDuration:duration withCompletionBlock:^{
        if (compilationBlock) compilationBlock();
    }];
}

- (void)setConstraintBottom:(CGFloat)constraintBottom animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock
{
    [self setConstraintValue:constraintBottom withAttribute:NSLayoutAttributeBottom animatedWithDuration:duration withCompletionBlock:^{
        if (compilationBlock) compilationBlock();
    }];
}

- (void)setConstraintLeft:(CGFloat)constraintLeft animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock
{
    [self setConstraintLeading:constraintLeft animatedWithDuration:duration withCompletionBlock:^{
        if (compilationBlock) compilationBlock();
    }];
}

- (void)setConstraintRight:(CGFloat)constraintRight animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock
{
    [self setConstraintTrailing:duration animatedWithDuration:duration withCompletionBlock:^{
        if (compilationBlock) compilationBlock();
    }];
}

- (void)setConstraintLeading:(CGFloat)constraintLeading animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock
{
    [self setConstraintValue:constraintLeading withAttribute:NSLayoutAttributeLeading animatedWithDuration:duration withCompletionBlock:^{
        if (compilationBlock) compilationBlock();
    }];
}

- (void)setConstraintTrailing:(CGFloat)constraintTrailing animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock
{
    [self setConstraintValue:constraintTrailing withAttribute:NSLayoutAttributeTrailing animatedWithDuration:duration withCompletionBlock:^{
        if (compilationBlock) compilationBlock();
    }];
}

- (void)setConstraintCentrX:(CGFloat)constraintCentrX animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock
{
    [self setConstraintValue:constraintCentrX withAttribute:NSLayoutAttributeCenterX animatedWithDuration:duration withCompletionBlock:^{
        if (compilationBlock) compilationBlock();
    }];
}

- (void)setConstraintCentrY:(CGFloat)constraintCentrY animatedWithDuration:(NSTimeInterval)duration withCompletionBlock:(SFConstraintCompletionBlock)compilationBlock
{
    [self setConstraintValue:constraintCentrY withAttribute:NSLayoutAttributeCenterY animatedWithDuration:duration withCompletionBlock:^{
        if (compilationBlock) compilationBlock();
    }];
}

@end
