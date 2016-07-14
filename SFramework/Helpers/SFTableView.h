//
//  SFTableView.h
//  SFramevork
//
//  Created by Sattar Falahati on 12/07/16.
//
//

#import <UIKit/UIKit.h>

@interface UITableView (SFTableView)

- (void)refreshTableView;
- (void)scroolTableToLastCell:(NSInteger)cellRow;

@end
