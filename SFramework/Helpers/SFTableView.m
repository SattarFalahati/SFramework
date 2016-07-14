//
//  SFTableView.m
//  SFramevork
//
//  Created by Sattar Falahati on 12/07/16.
//
//

#import "SFTableView.h"

@implementation  UITableView (SFTableView) 

- (void)refreshTableView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self
                          duration:0.35f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^(void) {
                            [self reloadData];
                        } completion:NULL];
    });
}

- (void)scroolTableToLastCell:(NSInteger)cellRow
{
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:cellRow inSection:0];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
