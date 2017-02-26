//
//  ServiceTimeViewController.h
//  Reservation
//
//  Created by Chinna on 2/19/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ServiceTimeViewControllerDelegate <NSObject>

- (void)selectedTimeInStringFormat:(NSString *)timeString;

@end


@interface ServiceTimeViewController : UIViewController

@property (weak, nonatomic) id<ServiceTimeViewControllerDelegate> delegate;

@end
