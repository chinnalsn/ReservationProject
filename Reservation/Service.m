//
//  Service.m
//  Reservation
//
//  Created by Chinna on 2/18/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "Service.h"

@implementation Service

- (instancetype)initWithOffer:(NSString *)offer service:(NSString *)serviceName available:(NSString *) offerAvailableOn imageName:(NSString *)imageName{
    self = [super init];
    self.offer = offer;
    self.serviceName = serviceName;
    self.offerAvailableOn = offerAvailableOn;
    self.imageName = imageName;
    
    return self;
}

@end
