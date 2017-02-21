//
//  TimeView.h
//  Reservation
//
//  Created by Chinna on 2/19/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeView : UIView
@property (weak, nonatomic) IBOutlet UIButton *timeActionButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

+ (TimeView *)getTimeView;

@end
