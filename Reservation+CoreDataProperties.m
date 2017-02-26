//
//  Reservation+CoreDataProperties.m
//  
//
//  Created by Chinna on 2/25/17.
//
//  This file was automatically generated and should not be edited.
//

#import "Reservation+CoreDataProperties.h"

@implementation Reservation (CoreDataProperties)

+ (NSFetchRequest<Reservation *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
}

@dynamic dateInStringFormat;
@dynamic partyDuration;
@dynamic partySize;
@dynamic serviceDescription;
@dynamic serviceName;
@dynamic time;

@end
