//
//  SFTableView.h
//  SFramevork
//
//  Created by Sattar Falahati on 12/07/16.
//
//

#import <UIKit/UIKit.h>

@interface UITableView (SFTableView)

// MARK: - REFRESH ( RELOAD DATA )

/// Refresh table view
- (void)refreshTableView;

/// Refresh specific cell at index path
- (void)refreshCellAtIndexPath:(NSInteger)row inSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

// MARK: - SCROLL OPTIONS

/// Scrool to last cell in section
- (void)scroolTableToLastCell:(NSInteger)cellRow inSection:(NSInteger)section;

/// Scrool table to the top with animation
- (void)scroolTableToTheTopWithAnimated:(BOOL)animated;

/// Scrool table to the bottom with animation
- (void)scroolTableToTheBottomWithAnimated:(BOOL)animated;

// MARK: SIZE

/// Override del metodo di sistema: permette di calcolare il contentSize esatto della TableView.
- (CGSize)realContentSize;

@end
