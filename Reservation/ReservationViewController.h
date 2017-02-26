//
//  ReservationViewController.h
//  Reservation
//
//  Created by Chinna on 2/18/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reservation;

@protocol ReservationViewControllerDelegate <NSObject>

- (void)addReservation:(Reservation *)newReservation;

@end

@interface ReservationViewController : UIViewController

@property(nonatomic, weak) id<ReservationViewControllerDelegate> delegate;

@end
