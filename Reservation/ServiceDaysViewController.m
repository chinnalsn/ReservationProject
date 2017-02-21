//
//  ServiceDaysViewController.m
//  Reservation
//
//  Created by Chinna on 2/19/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "ServiceDaysViewController.h"
#import "DayView.h"

@interface ServiceDaysViewController ()
@property (weak, nonatomic) IBOutlet UIView *daysContainerView;
@property (nonatomic, assign) NSInteger numberOfDaysInCurrentMonth;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (strong, nonatomic) NSArray *weekDays;
@property (strong, nonatomic) NSArray *months;
@end

@implementation ServiceDaysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weekDays = @[@"MON", @"TUE", @"WED", @"THU", @"FRI", @"SAT", @"SUN"];
    self.months = @[@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
    
    [self getDatesForMonth:4];
    [self addDays];
    
}

- (void)displayDaysForMonth:(NSInteger) month {
    
    
}

- (void)getDatesForMonth:(NSInteger) month {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setYear:2017];
    [components setMonth:month];
    
    NSDate *date = [calendar dateFromComponents:components];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    self.numberOfDaysInCurrentMonth = range.length;
}


- (void)addDays {
    
    if (self.numberOfDaysInCurrentMonth == 0) {
        return;
    }
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSMutableString * horzontalConstraintString = [NSMutableString stringWithFormat:@"H:|"];
    
    for (int i = 0; i<self.numberOfDaysInCurrentMonth; i++) {
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        
        [components setYear:2017];
        [components setMonth:4];
        [components setDay:i];
        
        NSDate *date = [calendar dateFromComponents:components];
        NSDateComponents* comp = [calendar components:NSCalendarUnitWeekday fromDate:date];
        
        
        DayView *dayView = [DayView getDayView];
        int index = i+1;
        
        if (index< 10) {
            dayView.dateLabel.text = [NSString stringWithFormat:@"0%d",index];
        }
        else {
            dayView.dateLabel.text = [NSString stringWithFormat:@"%d",index];
        }
        
        dayView.dayLabel.text = [self.weekDays objectAtIndex:([comp weekday] - 1)];
        [dayView.dayDateOverlayButton addTarget:self action:@selector(dayClickAction:) forControlEvents:UIControlEventTouchUpInside];
        dayView.dayDateOverlayButton.tag = i;
        
        dayView.tag = i;
        dayView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.daysContainerView addSubview:dayView];
        
        NSString * dayViewKey = [NSString stringWithFormat:@"dayViewKey_%d", i];
        [horzontalConstraintString appendString:[NSString stringWithFormat:@"-10-[%@(==80)]",dayViewKey]];
        
        [dict setObject:dayView forKey:dayViewKey];
        
        [self.daysContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-|",dayViewKey] options:0 metrics:0 views:dict]];
        
    }
    
    self.daysContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [horzontalConstraintString appendString:@"-10-|"];
    [self.daysContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horzontalConstraintString options:0 metrics:0 views:dict]];
}

- (void)dayClickAction:(UIButton *)button {
    
}

@end
