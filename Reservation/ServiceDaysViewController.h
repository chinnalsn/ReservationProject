//
//  ServiceDaysViewController.h
//  Reservation
//
//  Created by Chinna on 2/19/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ServiceDaysViewControllerDelegate <NSObject>

- (void)selectedDateInStringFormat:(NSString *)dateString;

@end

@interface ServiceDaysViewController : UIViewController

@property (weak, nonatomic) id<ServiceDaysViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *viewCalenderButton;

- (void)getDatesForMonth:(NSInteger) month;

@end
