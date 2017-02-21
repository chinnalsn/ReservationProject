//
//  TimeView.m
//  Reservation
//
//  Created by Chinna on 2/19/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "TimeView.h"
#import "ionicons/IonIcons.h"

@implementation TimeView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.timeLabel.font = [IonIcons fontWithSize:20];
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor grayColor].CGColor;
}

+ (TimeView *)getTimeView {
    return [[[NSBundle mainBundle] loadNibNamed:@"TimeView" owner:self options:nil] firstObject];
}

@end
