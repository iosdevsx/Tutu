//
//  JDDatePickerViewController.h
//  TutuTest
//
//  Created by jsd on 21.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDDatePickerDelegate;

@interface JDDatePicker : UIViewController

@property (strong, nonatomic) NSDate* currentDate;
@property (weak, nonatomic) id <JDDatePickerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *dateControl;

@end

@protocol JDDatePickerDelegate <NSObject>

- (void) didSelectedDate: (NSDate*) date;

@end
