//
//  JDScheduleController.m
//  TutuTest
//
//  Created by jsd on 19.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDScheduleController.h"
#import "JDStationsViewController.h"
#import "JDAboutViewController.h"
#import "JDDatePicker.h"
#import "NSString+DateHelper.h"

static NSString* bgImageSnow = @"bg-snowy";
static NSString* bgImageSunny = @"bg-sunny";

static NSString* FromKey = @"citiesFrom";
static NSString* ToKey = @"citiesTo";

@interface JDScheduleController () <JDStationDelegate, JDDatePickerDelegate, UIPopoverPresentationControllerDelegate, UIAdaptivePresentationControllerDelegate>

@property (strong, nonatomic) NSDictionary* jsonObject;
@property (strong, nonatomic) UITextField* selectedTextField;
@property (strong, nonatomic) NSDate* selectedDate;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end

@implementation JDScheduleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError* error = nil;
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"allStations" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    
    self.jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error)
    {
        //Ok... :(
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods

//Показываем таблицу со станциями
- (void) showStationsForkey: (NSString*) key andTextField: (UITextField*) textField
{
    if (textField)
    {
        self.selectedTextField = textField;
    }
    JDStationsViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([JDStationsViewController class])];
    if (self.jsonObject)
    {
        vc.items = [self.jsonObject valueForKey:key];
    }
    vc.delegate = self;
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

//Показываем popover с выбором даты
- (void) showDatePickerForSource: (UIView*) source
{
    JDDatePicker* picker = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([JDDatePicker class])];
    picker.delegate = self;
    if (self.selectedDate)
    {
        picker.currentDate = self.selectedDate;
    }
    picker.modalPresentationStyle = UIModalPresentationPopover;
    [self getPopoverForController:picker andSource:source];
    [self presentViewController:picker animated:YES completion:nil];
}

//Конфигурируем поповер
- (UIPopoverPresentationController*) getPopoverForController: (UIViewController*) controller andSource: (UIView*) source
{
    UIPopoverPresentationController* popover = controller.popoverPresentationController;
    popover.delegate = self;
    popover.sourceView = source;
    popover.sourceRect = CGRectMake(CGRectGetMidX(source.bounds), CGRectGetHeight(source.bounds), 0, 0);
    popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    return popover;
}

//Меняем фон в зависимости от выбранного месяца
- (void) changeBackgroundForDate: (NSDate*) date
{
    if (self.selectedDate)
    {
        NSDateComponents* components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:date];
        NSInteger month = [components month];
        JDAboutViewController* vc = [self.tabBarController.viewControllers lastObject];
        if (month > 10 || month < 3)
        {
            vc.backgroundImage.image = [UIImage imageNamed:bgImageSnow];
            [self animateImageView:self.backgroundImage withImageKey:bgImageSnow];
        } else
        {
            vc.backgroundImage.image = [UIImage imageNamed:bgImageSunny];
            [self animateImageView:self.backgroundImage withImageKey:bgImageSunny];
        }
    }
}

//Анимация для смены фона
- (void) animateImageView: (UIImageView*) imageView withImageKey: (NSString*) image
{
    imageView.image = nil;
    imageView.image = [UIImage imageNamed:image];
    CATransition* transition = [CATransition animation];
    transition.duration = 2.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [imageView.layer addAnimation:transition forKey:nil];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.stationFromLabel])
    {
        [self showStationsForkey:FromKey andTextField:textField];
    } else if ([textField isEqual:self.stationToLabel])
    {
        [self showStationsForkey:ToKey andTextField:textField];
        self.selectedTextField = textField;
    } else if ([textField isEqual:self.dateLabel])
    {
        [self showDatePickerForSource:textField];
    }
    
    return NO;
}

#pragma mark - JDStationDelegate

//Метод делегата в который приходит выбранная пользователем станция
- (void) didSelectedStation: (JDStation*) station
{
    if (self.selectedTextField)
    {
        if ([self.selectedTextField isEqual:self.stationFromLabel])
        {
            self.stationFromLabel.text = station.stationTitle;
        } else
        {
            self.stationToLabel.text = station.stationTitle;
        }
    }
}

#pragma mark - JDDatePickerDelegate

//Метод делегата, в который приходит дата
-(void) didSelectedDate: (NSDate*) date
{
    [self changeBackgroundForDate:date];
    self.selectedDate = date;
    self.dateLabel.text = [NSString formattedDate:date];
}

#pragma mark -UIAdaptivePresentationControllerDelegate

//Ставим none что бы на iPhone тоже отображался popover
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

@end
