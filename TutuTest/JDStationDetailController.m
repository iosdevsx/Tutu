//
//  JDStationDetailController.m
//  TutuTest
//
//  Created by jsd on 21.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDStationDetailController.h"
#import "JDMapAnnotation.h"

@interface JDStationDetailController ()

@property (weak, nonatomic) IBOutlet UILabel *stationLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation JDStationDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.stationLabel.text = self.station.stationTitle;
    self.cityLabel.text = self.station.cityTitle;
    self.countryLabel.text = self.station.countryTitle;
    [self addAnnotation];
    
    self.navigationItem.title = NSLocalizedString(@"station_info", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MapKit

//Отмечаем на карте станцию
- (void) addAnnotation
{
    JDMapAnnotation* annotation = [[JDMapAnnotation alloc] init];
    annotation.title = self.station.stationTitle;
    annotation.coordinate = self.station.point;
    
    [self.mapView addAnnotation:annotation];
    [self showAllAnnotations];
}

//Настраиваем зону видимости для точки
- (void)showAllAnnotations
{
    MKMapRect zoom = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations)
    {
        CLLocationCoordinate2D coordinate = annotation.coordinate;
        MKMapPoint location = MKMapPointForCoordinate(coordinate);
        
        static double delta = 20000;
        MKMapRect rect = MKMapRectMake(location.x - delta, location.y - delta, delta*2, delta*2);
        zoom = MKMapRectUnion(zoom, rect);
    }
    zoom = [self.mapView mapRectThatFits:zoom];
    [self.mapView setVisibleMapRect:zoom edgePadding:UIEdgeInsetsMake(100, 100, 100, 100) animated:YES];
}

@end
