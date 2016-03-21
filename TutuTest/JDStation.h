//
//  JDStation.h
//  TutuTest
//
//  Created by jsd on 20.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface JDStation : NSObject

@property (strong, nonatomic) NSString* stationTitle;
@property (strong, nonatomic) NSString* cityTitle;
@property (strong, nonatomic) NSString* countryTitle;
@property (assign, nonatomic) CLLocationCoordinate2D point;

- (instancetype)initWithFields: (NSDictionary*) fields;

@end
