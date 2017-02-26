//
//  ServiceDaysViewController.m
//  Reservation
//
//  Created by Chinna on 2/19/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "ServiceDaysViewController.h"
#import "DayView.h"
#import "ReservationUtilities.h"

@interface ServiceDaysViewController ()
@property (weak, nonatomic) IBOutlet UIView *daysContainerView;
@property (nonatomic, assign) NSInteger numberOfDaysInCurrentMonth;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (strong, nonatomic) NSMutableArray *displayDates;
@property (strong, nonatomic) UIButton *previousSelectedButton;
@property (strong, nonatomic) NSDate *selectedDate;
@end

@implementation ServiceDaysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayDates = [[NSMutableArray alloc]init];

    self.selectedDate = [NSDate date];
    [self updateDatesForSelectedDate];
}

- (void)updateDatesForSelectedDate {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.selectedDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"MMMM"];
    
    self.monthLabel.text = [[dateFormatter stringFromDate:self.selectedDate] uppercaseString];
    
    self.numberOfDaysInCurrentMonth = range.length;

    [self addDays];

}

- (void)getDatesForMonth:(NSInteger) month {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setYear:2017];
    [components setMonth:month];
    
    self.selectedDate = [calendar dateFromComponents:components];
    
    [self updateDatesForSelectedDate];
    
}

- (void)addDays {
    
    [[self.daysContainerView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayDates removeAllObjects];

    if (self.numberOfDaysInCurrentMonth == 0) {
        return;
    }
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSMutableString * horzontalConstraintString = [NSMutableString stringWithFormat:@"H:|"];
    
    for (int day = 1; day<=self.numberOfDaysInCurrentMonth; day++) {
    
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self.selectedDate];
        components.day = day;
        
        NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
        [weekday setDateFormat: @"EE"];

        NSDate *dateInCurrentMonth = [calendar dateFromComponents:components];
        
        [self.displayDates addObject:dateInCurrentMonth];
       
        DayView *dayView = [DayView getDayView];
        
        if (day< 10) {
            dayView.dateLabel.text = [NSString stringWithFormat:@"0%d",day];
        }
        else {
            dayView.dateLabel.text = [NSString stringWithFormat:@"%d",day];
        }
        
        dayView.dayLabel.text = [[weekday stringFromDate:dateInCurrentMonth] uppercaseString];
        [dayView.dayDateOverlayButton addTarget:self action:@selector(dayClickAction:) forControlEvents:UIControlEventTouchUpInside];
        dayView.dayDateOverlayButton.tag = day - 1;
        
        dayView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.daysContainerView addSubview:dayView];
        
        NSString * dayViewKey = [NSString stringWithFormat:@"dayViewKey_%d", day];
        
        [horzontalConstraintString appendString:[NSString stringWithFormat:@"-%d-[%@(==55)]",( day == 1 ? 0 :10),dayViewKey]];
        
        [dict setObject:dayView forKey:dayViewKey];
        
        [self.daysContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-|",dayViewKey] options:0 metrics:0 views:dict]];
        
    }
    
    self.daysContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [horzontalConstraintString appendString:@"-0-|"];
    [self.daysContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horzontalConstraintString options:0 metrics:0 views:dict]];
}

- (void)dayClickAction:(UIButton *)button {
    if (self.previousSelectedButton && ![self.previousSelectedButton isEqual:button]) {
        [ReservationUtilities removeCheckmarkOutlineIcon:self.previousSelectedButton];
    }
    if ([button isSelected])
    {
        [self.delegate selectedDateInStringFormat:nil];
        [ReservationUtilities removeCheckmarkOutlineIcon:button];
    }
    else
    {
        NSDate *selectedDate = self.displayDates[button.tag];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"EEEE, MMMM dd, YYYY"];
        
        [self.delegate selectedDateInStringFormat:[dateFormatter stringFromDate:selectedDate]];
        [ReservationUtilities setCheckmarkOutlineIcon:button];
    }
    
    self.previousSelectedButton = button;
}



@end
