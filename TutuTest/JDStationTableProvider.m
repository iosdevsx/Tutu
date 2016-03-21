//
//  JDStationTableProvider.m
//  TutuTest
//
//  Created by jsd on 21.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDStationTableProvider.h"
#import "JDStationDetailController.h"
#import "JDStationCell.h"
#import "JDStation.h"

static NSString* CellId = @"JDStationCell";

@interface JDStationTableProvider ()

@end

@implementation JDStationTableProvider

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active)
    {
        if (self.filteredItems.count > 0)
        {
            return [self.filteredItems count];
        } else
        {
            return [self.items count];
        }
        
    } else
    {
        return [self.items count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDStationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    JDStation* station;
    if (self.searchController.active)
    {
        if (self.filteredItems.count > 0)
        {
            station = [self.filteredItems objectAtIndex:indexPath.row];
        } else
        {
            station = [self.items objectAtIndex:indexPath.row];
        }
    } else
    {
        station = [self.items objectAtIndex:indexPath.row];
    }
    cell.locationLabel.text = [NSString stringWithFormat:@"%@, %@", station.countryTitle, station.cityTitle];
    cell.stationLabel.text = station.stationTitle;
    
    return cell;
}

#pragma mark - UITableViewDelegate

//Передаем в метод делегата выбранную станцию и закрываем контроллер
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchController.active && self.filteredItems.count > 0)
    {
        self.items = self.filteredItems;
    }
    [self.searchController dismissViewControllerAnimated:NO completion:nil];
    [self.delegate cellSelectedAtIndexPath:indexPath];
}

#pragma mark - UISearchResultsUpdating

//Обновляем таблицу учитывая критерии поиска
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    self.filteredItems = nil;
    NSPredicate* searchPredicate = [NSPredicate predicateWithFormat:@"stationTitle BEGINSWITH[cd] %@", searchController.searchBar.text];
    self.filteredItems = [self.items filteredArrayUsingPredicate:searchPredicate];
    [self.delegate searchComplete];
}

@end
