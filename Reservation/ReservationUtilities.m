//
//  ReservationUtilities.m
//  Reservation
//
//  Created by Chinna on 2/22/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "ReservationUtilities.h"

@implementation ReservationUtilities

+ (void)setCheckmarkOutlineIcon:(UIButton *)button {
    
    UIImage *icon = [IonIcons imageWithIcon:ion_ios_checkmark_outline
                                  iconColor:[UIColor whiteColor]
                                   iconSize:26.5
                                  imageSize:button.frame.size];
    
    [button setImage:icon forState:UIControlStateSelected];
    [button setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:128.0f/255.0f blue:255.0f/255.0f alpha:0.4]];
    [button setSelected:YES];
}

+ (void)removeCheckmarkOutlineIcon:(UIButton *)button {
    [button setImage:nil forState:UIControlStateNormal];
    [button setSelected:NO];
    [button setBackgroundColor:[UIColor clearColor]];
}

@end
