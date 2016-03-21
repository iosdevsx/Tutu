//
//  JDMapAnnotation.h
//  TutuTest
//
//  Created by jsd on 21.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface JDMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

@end
