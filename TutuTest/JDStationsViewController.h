//
//  JDStationsViewController.h
//  TutuTest
//
//  Created by jsd on 20.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDStation.h"

@protocol JDStationDelegate;

@interface JDStationsViewController : UITableViewController

@property (weak, nonatomic) id <JDStationDelegate> delegate;
@property (strong, nonatomic) NSArray* items;

@end

@protocol JDStationDelegate <NSObject>

- (void) didSelectedStation: (JDStation*) station;

@end


