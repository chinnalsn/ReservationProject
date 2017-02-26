//
//  CalenderViewController.m
//  Reservation
//
//  Created by Chinna on 2/25/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "CalenderViewController.h"

@interface CalenderViewController ()

@end

@implementation CalenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate]; // Get necessary date components
    
    NSInteger currentMonth = [components month];
    
    NSInteger baseTag = 100;
    
    for (int i = 1; i< currentMonth; i++) {
        UIButton *button =  [self.view viewWithTag:(baseTag + i)];
        button.enabled = false;
        button.alpha = 0.6;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)monthButtonAction:(UIButton *)sender {
    
    NSInteger baseTag = 100;
    NSInteger selectedMonth = (sender.tag - baseTag);
    [self.delegate selectedMonth:selectedMonth];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
