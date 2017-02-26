//
//  ServiceView.m
//  Reservation
//
//  Created by Chinna on 2/22/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "ServiceView.h"

@implementation ServiceView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *subview = [super hitTest:point withEvent:event];
    return ([subview isKindOfClass:[UIButton class]] || [[subview superview] isKindOfClass:[UITableViewCell class]]) ? subview : nil;
}

@end
