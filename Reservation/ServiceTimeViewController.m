//
//  ServiceTimeViewController.m
//  Reservation
//
//  Created by Chinna on 2/19/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "ServiceTimeViewController.h"
#import "TimeView.h"

@interface ServiceTimeViewController ()
@property (weak, nonatomic) IBOutlet UIView *timeContainerView;
@property (strong, nonatomic) NSArray *timesArray;
@property (weak, nonatomic) IBOutlet UILabel *availableTimesLabel;

@end

@implementation ServiceTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timesArray = @[@[@"9:00 AM", @"10:00 AM", @"11:00 AM"], @[@"12:00 PM", @"1:00 PM", @"2:00 PM"], @[@"3:00 PM", @"4:00 PM", @"5:00 PM"], @[@"6:00 PM", @"7:00 PM", @"8:00 PM"]];
    
    [self displayServiceTimings];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayServiceTimings {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSMutableString * horzontalConstraintString = [NSMutableString stringWithFormat:@"H:|"];
    
    for (int i = 0; i<self.timesArray.count; i++) {
        
        NSArray *listOfTimesInColumn = [self.timesArray objectAtIndex:i];
        UIView *timeCloumnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        timeCloumnView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.timeContainerView addSubview:timeCloumnView];
        
        NSString * timeCloumnViewKey = [NSString stringWithFormat:@"timeCloumnViewKey_%d", i];
        [horzontalConstraintString appendString:[NSString stringWithFormat:@"-10-[%@(==150)]",timeCloumnViewKey]];
        
        [dict setObject:timeCloumnView forKey:timeCloumnViewKey];
        
        [self.timeContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-|",timeCloumnViewKey] options:0 metrics:0 views:dict]];
        
        [self addTimes:listOfTimesInColumn toColumnIndex:i toColumnView:timeCloumnView];
    }
    
    self.timeContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [horzontalConstraintString appendString:@"-10-|"];
    [self.timeContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horzontalConstraintString options:0 metrics:0 views:dict]];
}

- (void)addTimes:(NSArray *)rowTimes toColumnIndex:(NSInteger)index toColumnView:(UIView *)timeCloumnView {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSMutableString * verticalConstraintString = [NSMutableString stringWithFormat:@"V:|"];
    
    for (int i = 0; i<rowTimes.count; i++) {
        
        TimeView *timeRowView = [TimeView getTimeView];
        timeRowView.timeLabel.text = [rowTimes objectAtIndex:i];
        [timeRowView.timeActionButton addTarget:self action:@selector(timeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        timeRowView.timeActionButton.tag = (rowTimes.count*index) + i;
        
        timeRowView.translatesAutoresizingMaskIntoConstraints = NO;
        [timeCloumnView addSubview:timeRowView];
       
        NSString * timeRowViewKey = [NSString stringWithFormat:@"timeRowViewKey_%lu", ((rowTimes.count*index) + i)];
        [verticalConstraintString appendString:[NSString stringWithFormat:@"-10-[%@(==54)]",timeRowViewKey]];
        
        [dict setObject:timeRowView forKey:timeRowViewKey];
        
        [timeCloumnView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[%@]-0-|",timeRowViewKey] options:0 metrics:0 views:dict]];
        
    }
    
    timeCloumnView.translatesAutoresizingMaskIntoConstraints = NO;
    [verticalConstraintString appendString:@"-(>=5)-|"];
    [timeCloumnView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintString options:0 metrics:0 views:dict]];
}

- (void)timeButtonAction:(UIButton *)button {
    
}

@end
