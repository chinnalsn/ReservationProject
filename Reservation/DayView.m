//
//  DayView.m
//  Reservation
//
//  Created by Chinna on 2/19/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "DayView.h"
#import "ionicons/IonIcons.h"

@implementation DayView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dayLabel.font = [IonIcons fontWithSize:20];
    self.dateLabel.font = [IonIcons fontWithSize:30];
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor grayColor].CGColor;
}

+ (DayView *)getDayView {
    return [[[NSBundle mainBundle] loadNibNamed:@"DayView" owner:self options:nil] firstObject];
}


@end
