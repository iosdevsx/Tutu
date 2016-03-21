//
//  JDStationsViewController.m
//  TutuTest
//
//  Created by jsd on 20.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDStationsViewController.h"
#import "JDStationDetailController.h"
#import "JDStationTableProvider.h"

@interface JDStationsViewController () <JDBaseTableDelegate>

@property (strong, nonatomic) NSArray* stations;
@property (strong, nonatomic) JDStationTableProvider* provider;
@property (strong, nonatomic) UISearchController* searchController;

@end

@implementation JDStationsViewController

-(void)loadView
{
    [super loadView];
    
    //Инициализируем провайдера для таблицы и заодно контроллер для поиска
    self.provider = [[JDStationTableProvider alloc] init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.searchController.searchResultsUpdater = self.provider;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.provider.delegate = self;
    self.provider.searchController = self.searchController;
    self.tableView.delegate = self.provider;
    self.tableView.dataSource = self.provider;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.provider.items = [self getStationsFromCitiesArray:self.items];
    [self.tableView reloadData];
    
    self.navigationItem.title = NSLocalizedString(@"station", nil);
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionCancel)];
    [self.navigationItem setRightBarButtonItem:item];
}

-(void)dealloc
{
    [self.searchController.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

//Парсим входные dictionary на объекты и возвращаем отсортированные по стране, затем по городу
- (NSArray*) getStationsFromCitiesArray: (NSArray*) array
{
    NSMutableArray* temp = [NSMutableArray array];
    for (NSDictionary* fields in array)
    {
        NSArray* stations = [fields valueForKey:@"stations"];
        for (NSDictionary* stationFields in stations)
        {
            JDStation* station = [[JDStation alloc] initWithFields:stationFields];
            [temp addObject:station];
        }
    }
    
    NSSortDescriptor* country = [[NSSortDescriptor alloc] initWithKey:@"countryTitle" ascending:YES];
    NSSortDescriptor* city = [[NSSortDescriptor alloc] initWithKey:@"cityTitle" ascending:YES];
    
    return [temp sortedArrayUsingDescriptors:@[country, city]];
}

#pragma mark - Actions

- (void) actionCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - JDBaseTableDelegate

//Методы делегата провайдера

- (void) cellSelectedAtIndexPath: (nullable NSIndexPath*) indexPath
{
    JDStation* selectedStation = [self.provider.items objectAtIndex:indexPath.row];
    [self.delegate didSelectedStation:selectedStation];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) accessorySelectedAtIndexPath: (nullable NSIndexPath*) indexPath
{
    JDStation* selectedStation = [self.provider.items objectAtIndex:indexPath.row];
    JDStationDetailController* vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([JDStationDetailController class])];
    vc.station = selectedStation;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)searchComplete
{
    [self.tableView reloadData];
}

@end
