//
//  Service.h
//  Reservation
//
//  Created by Chinna on 2/18/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject

@property (nonatomic, strong) NSString *offer;
@property (nonatomic, strong) NSString *serviceName;
@property (nonatomic, strong) NSString *offerAvailableOn;
@property (nonatomic, strong) NSString *imageName;

- (instancetype)initWithOffer:(NSString *)offer service:(NSString *)serviceName available:(NSString *) offerAvailableOn imageName:(NSString *)imageName;
@end
