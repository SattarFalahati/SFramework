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

// MARK: - REFRESH ( RELOAD DATA )

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

// MARK: - SCROLL OPTIONS

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

// MARK: TABLE SIZE

- (CGSize)realContentSize
{
    // Get current table view with delegate
    UITableView *tableView = self;
    id <UITableViewDataSource> dataSource = self.dataSource;
    id <UITableViewDelegate> delegate = self.delegate;
    
    [tableView layoutIfNeeded];
    
    // Create content size (basic + at the begining the height is 0)
    CGSize contentSize = CGSizeMake(tableView.frame.size.width, 0.0);
    
    // Check when the delagete getting called
    if ([tableView respondsToSelector:@selector(numberOfSections)]) {
        
        // Calculate Height for each section
        for (NSUInteger section = 0; section < [tableView numberOfSections]; section++) {
            // Header in a section
            if ([dataSource respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
                contentSize.height += [delegate tableView:tableView heightForHeaderInSection:section];
            }
            
            // Cells in a section (Check when delegate for cells getting called)
            if ([dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
                
                // Calculate Height for each row
                for (NSUInteger row = 0; row < [dataSource tableView:tableView numberOfRowsInSection:section]; row++) {
                    if ([dataSource respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                        CGFloat height = [delegate tableView:tableView heightForRowAtIndexPath:indexPath];
                        
                        if (height == UITableViewAutomaticDimension) {
                            // EXPLNATION: Table will calculate the hight automaticly but we need to calculate it precisely.
                            if ([dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
                                UITableViewCell *cell = [dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
                                [cell setNeedsLayout];
                                [cell layoutIfNeeded];
                                
                                CGSize size = [cell systemLayoutSizeFittingSize:CGSizeMake(contentSize.width, 0.0) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
                                height = size.height;
                            }
                            else if ([delegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
                                height = [delegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
                            }
                            else {
                                height = tableView.estimatedRowHeight;
                            }
                        }
                        
                        contentSize.height += height;
                    }
                    else {
                        contentSize.height += tableView.rowHeight;
                    }
                }
            }
            
            // Footer in a section
            if ([dataSource respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
                contentSize.height += [delegate tableView:tableView heightForFooterInSection:section];
            }
        }
    }
    
    return contentSize;
}


@end
