//
//  SFTableView.m
//  SFramevork
//
//  Created by Sattar Falahati on 12/07/16.
//
//

#import "SFTableView.h"


#define kRefreshTableAnimationDuration      0.3f

@implementation  UITableView (SFTableView) 

#pragma mark - REFRESH ( RELOAD DATA )

- (void)refreshTableView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self
                          duration:kRefreshTableAnimationDuration
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^(void) {
                            [self reloadData];
                        } completion:NULL];
    });
}

- (void)refreshCellAtIndexPath:(NSInteger)row inSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    
    NSArray *arrIndex = [NSArray arrayWithObject:indexPath];
    
    [self beginUpdates];
    [self reloadRowsAtIndexPaths:arrIndex withRowAnimation:animation];
    [self endUpdates];
}

#pragma mark - SCROLL OPTIONS

- (void)scroolTableToLastCell:(NSInteger)cellRow inSection:(NSInteger)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cellRow inSection:section];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)scroolTableToTheTopWithAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointZero animated:animated];
}

- (void)scroolTableToTheBottomWithAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0, CGFLOAT_MAX) animated:animated];

}

@end
