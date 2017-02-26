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
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithRed:247/255 green:248/255 blue:248/255 alpha:0.1].CGColor;
}

+ (TimeView *)getTimeView {
    return [[[NSBundle mainBundle] loadNibNamed:@"TimeView" owner:self options:nil] firstObject];
}

@end
