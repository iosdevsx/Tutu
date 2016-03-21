//
//  NSString+DateHelper.m
//  TutuTest
//
//  Created by jsd on 22.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "NSString+DateHelper.h"

@implementation NSString (DateHelper)

+ (NSString*) formattedDate: (NSDate*) date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    return [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
}

@end
