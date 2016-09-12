//
//  SFTableView.h
//  SFramevork
//
//  Created by Sattar Falahati on 12/07/16.
//
//

#import <UIKit/UIKit.h>

@interface UITableView (SFTableView)

/// Refresh table view
- (void)refreshTableView;

/// Scrool to the end of the table view
- (void)scroolTableToLastCell:(NSInteger)cellRow inSection:(NSInteger)section;

/// Refresh specific cell at index path
- (void)refreshCellAtIndexPath:(NSInteger)row inSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

@end
