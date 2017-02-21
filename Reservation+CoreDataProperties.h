//
//  Reservation+CoreDataProperties.h
//  
//
//  Created by Chinna on 2/20/17.
//
//  This file was automatically generated and should not be edited.
//

#import "Reservation+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Reservation (CoreDataProperties)

+ (NSFetchRequest<Reservation *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *dateInStringFormat;
@property (nullable, nonatomic, copy) NSString *time;
@property (nullable, nonatomic, copy) NSString *serviceName;
@property (nonatomic) int32_t partySize;
@property (nullable, nonatomic, copy) NSString *partyDuration;
@property (nullable, nonatomic, copy) NSString *serviceDescription;

@end

NS_ASSUME_NONNULL_END
