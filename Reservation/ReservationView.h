//
//  ReservationView.h
//  Reservation
//
//  Created by Chinna on 2/17/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservationView : UIView

@property (weak, nonatomic) IBOutlet UIView *dateTimeContainerView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *partySize;
@property (weak, nonatomic) IBOutlet UILabel *partyDuration;
@property (weak, nonatomic) IBOutlet UIView *deviderLineView;
@property (weak, nonatomic) IBOutlet UILabel *serviceDetailsLabel;
@property (weak, nonatomic) IBOutlet UIButton *reserveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


+ (ReservationView *)reservationView;

@end
