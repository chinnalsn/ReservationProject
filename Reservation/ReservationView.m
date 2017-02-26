//
//  ReservationView.m
//  Reservation
//
//  Created by Chinna on 2/17/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "ReservationView.h"
#import "ionicons/IonIcons.h"

//Custome view to display reservation details

@implementation ReservationView

+ (ReservationView *)reservationView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ReservationView" owner:self options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
   /* [self.timeLabel setFont:[IonIcons fontWithSize:19]];
    [self.dateLabel setFont:[IonIcons fontWithSize:19]];
    [self.serviceNameLabel setFont:[IonIcons fontWithSize:25]];
    [self.partySize setFont:[IonIcons fontWithSize:18]];
    [self.partyDuration setFont:[IonIcons fontWithSize:18]];
    [self.serviceDetailsLabel setFont:[IonIcons fontWithSize:15]];
    224
    */
    
    [self.reserveButton.layer setCornerRadius:3.0];
    [self.cancelButton.layer setCornerRadius:3.0];
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithRed:247/255 green:248/255 blue:248/255 alpha:0.1].CGColor;
}



@end
