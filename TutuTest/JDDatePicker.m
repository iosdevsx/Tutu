//
//  JDDatePickerViewController.m
//  TutuTest
//
//  Created by jsd on 21.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDDatePicker.h"

@interface JDDatePicker ()

@end

@implementation JDDatePicker

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.currentDate)
    {
        self.dateControl.date = self.currentDate;
    }
    
    [self.delegate didSelectedDate:self.dateControl.date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionDateChanged:(UIDatePicker *)sender
{
    [self.delegate didSelectedDate:sender.date];
}

@end
