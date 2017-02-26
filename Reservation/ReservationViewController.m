//
//  ReservationViewController.m
//  Reservation
//
//  Created by Chinna on 2/18/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "ReservationViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Reservation+CoreDataClass.h"
#import "ServiceDaysViewController.h"
#import "ServiceTimeViewController.h"
#import "CalenderViewController.h"

@interface ReservationViewController ()<ServiceDaysViewControllerDelegate, ServiceTimeViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, CalenderViewControllerDelegate>
@property (strong, nonatomic) NSString *selectedDate;
@property (strong, nonatomic) NSString *selectedTime;
@property (weak, nonatomic) IBOutlet UIButton *reserveButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerContainerViewBottomLayoutConstraint;

@property (weak, nonatomic) IBOutlet UILabel *partySizeLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *partySizeDatePicker;
@property (strong, nonatomic) NSArray *partySizeArray;
@property (strong, nonatomic) NSString *partySize;
@property (strong, nonatomic) ServiceDaysViewController * serviceDaysViewController;

@end

@implementation ReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"SCHEDULE";
    [self enableReserveButton:false];
    self.partySizeArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    self.partySize = [self.partySizeArray firstObject];
    
    self.partySizeLabel.layer.borderWidth = 0.5;
    self.partySizeLabel.layer.borderColor = [UIColor colorWithRed:247/255 green:248/255 blue:248/255 alpha:0.3].CGColor;
    [self.partySizeLabel.layer setCornerRadius:3.0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reserveAction:(id)sender {
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext  *managedObjectContext = delegate.managedObjectContext;
    
    Reservation *reservationObj = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:managedObjectContext];
    
    reservationObj.dateInStringFormat = self.selectedDate;
    reservationObj.time = self.selectedTime;
    reservationObj.serviceName = @"Hot Stone Massage";
    reservationObj.partySize = [self.partySize intValue];
    reservationObj.partyDuration = @"60M";
    reservationObj.serviceDescription = @"Massage focused on the deepest layer of muscles to tarte knots and release chronic muscle tension.";
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddReservation" object:self userInfo:@{@"reservationObj":reservationObj}];
    [self.navigationController popToRootViewControllerAnimated:YES];
    

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * segueName = segue.identifier;
    segue.destinationViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    if ([segueName isEqualToString: @"ServiceDaysViewController"]) {
        self.serviceDaysViewController =  (ServiceDaysViewController *) [segue destinationViewController];
        self.serviceDaysViewController.delegate = self;
        [self.serviceDaysViewController.viewCalenderButton addTarget:self action:@selector(showCalender) forControlEvents:UIControlEventTouchUpInside];
    }
    else if ([segueName isEqualToString: @"ServiceTimeViewController"]) {
        ServiceTimeViewController * serviceTimeViewController =  (ServiceTimeViewController *) [segue destinationViewController];
        serviceTimeViewController.delegate = self;
    }
}

- (void)selectedTimeInStringFormat:(NSString *)timeString {
    self.selectedTime = timeString;
    [self enableReserveButton:(self.selectedDate && self.selectedTime)];
}


- (void)selectedDateInStringFormat:(NSString *)dateString {
    self.selectedDate = dateString;
    [self enableReserveButton:(self.selectedDate && self.selectedTime)];
}

- (void)enableReserveButton:(BOOL)enable {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.reserveButton.alpha = enable ? 1 : 0.6;
                     }];

    [self.reserveButton setEnabled:enable];
}

- (IBAction)selectPartySize:(id)sender {
    [self showPicker:YES];
}


- (IBAction)partySizeSelectionCancelAction:(id)sender {
    [self showPicker:NO];
}

- (IBAction)partySizeSelectionDoneAction:(id)sender {
    self.partySizeLabel.text = self.partySize;
    [self showPicker:NO];
}

- (void)showPicker:(BOOL)show {
    NSInteger bottomeLayoutConstant = show ? 0 : -260;
    self.pickerContainerViewBottomLayoutConstraint.constant = bottomeLayoutConstant;
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.view layoutIfNeeded]; // Called on parent view
                     }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.partySizeArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.partySizeArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.partySize = self.partySizeArray[row];
}


- (void)showCalender {
   CalenderViewController * calenderViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"CalenderViewController"];
    calenderViewController.delegate = self;
    [self.navigationController pushViewController:calenderViewController animated:YES];
    
}

- (void)selectedMonth:(NSInteger)month {
    [self.serviceDaysViewController getDatesForMonth:month];
}


@end
