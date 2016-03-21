//
//  JDStation.m
//  TutuTest
//
//  Created by jsd on 20.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDStation.h"


@implementation JDStation

- (instancetype)initWithFields: (NSDictionary*) fields
{
    self = [super init];
    if (self)
    {
        self.cityTitle = [fields valueForKey:@"cityTitle"];
        self.countryTitle = [fields valueForKey:@"countryTitle"];
        self.stationTitle = [fields valueForKey:@"stationTitle"];
        NSDictionary* point = [fields valueForKey:@"point"];
        if (point)
        {
            self.point = CLLocationCoordinate2DMake([[point valueForKey:@"latitude"] doubleValue], [[point valueForKey:@"longitude"] doubleValue]);
        }
    }
    return self;
}

@end
