//
//  CalenderViewController.h
//  Reservation
//
//  Created by Chinna on 2/25/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalenderViewControllerDelegate <NSObject>

- (void)selectedMonth:(NSInteger)month;

@end

@interface CalenderViewController : UIViewController

@property (weak, nonatomic) id<CalenderViewControllerDelegate> delegate;

@end
