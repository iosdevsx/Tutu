//
//  JDBaseTableProvider.h
//  TutuTest
//
//  Created by jsd on 21.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDBaseTableDelegate;

@interface JDBaseTableProvider : NSObject <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

@property (nullable, strong, nonatomic) NSArray* items;
@property (nullable, strong, nonatomic) NSArray* filteredItems;
@property (nullable, strong, nonatomic) UISearchController* searchController;
@property (nullable, weak, nonatomic) id <JDBaseTableDelegate> delegate;

@end

@protocol JDBaseTableDelegate <NSObject>

@optional
- (void) cellSelectedAtIndexPath: (nullable NSIndexPath*) indexPath;
- (void) accessorySelectedAtIndexPath: (nullable NSIndexPath*) indexPath;
- (void) searchComplete;

@end
