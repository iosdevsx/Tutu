//
//  JDBaseTableProvider.m
//  TutuTest
//
//  Created by jsd on 21.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDBaseTableProvider.h"

@interface JDBaseTableProvider ()

@end

@implementation JDBaseTableProvider


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //переопределяется в дочернем классе
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate accessorySelectedAtIndexPath:indexPath];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //переопределяется в дочернем классе
}


@end
