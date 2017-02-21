//
//  ReservationsContainerViewController.m
//  Reservation
//
//  Created by Chinna on 2/18/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "ReservationsContainerViewController.h"
#import "ReservationView.h"
#import "ionicons/IonIcons.h"
#import "Reservation+CoreDataClass.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface ReservationsContainerViewController ()
@property (weak, nonatomic) IBOutlet UIView *reservationsContainerView;
@property (strong, nonatomic) UIFont *ionIconsFont;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *reservationsArray;
@end

@implementation ReservationsContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.ionIconsFont = [IonIcons fontWithSize:30.0f];
    [self getAllReservations];
}

- (void) getAllReservations {
   
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.managedObjectContext = delegate.persistentContainer.viewContext;
    NSError *error;
    NSAsynchronousFetchResult *storeResults = [self.managedObjectContext executeRequest:[Reservation fetchRequest] error:&error];
    self.reservationsArray = storeResults.finalResult;
    
    if (self.reservationsArray.count == 0) {
        
        Reservation *reservationOne = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.managedObjectContext];
        
        reservationOne.dateInStringFormat = @"Monday, March 26, 2017";
        reservationOne.time = @"2:00 PM";
        reservationOne.serviceName = @"Hot Stone";
        reservationOne.partySize = 1;
        reservationOne.partyDuration = @"30M";
        reservationOne.serviceDescription = @"Massage focused on the deepest layer of muscles to tarte knots and release chronic muscle tension.";
        
        Reservation *reservationTwo = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.managedObjectContext];
        
        reservationTwo.dateInStringFormat = @"Monday, March 26, 2017";
        reservationTwo.time = @"4:00 PM";
        reservationTwo.serviceName = @"Gel Manicure";
        reservationTwo.partySize = 1;
        reservationTwo.partyDuration = @"30M";
        reservationTwo.serviceDescription = @"Get upper hand with our chip-resistant, mirror-finish gel polish that requires no drying time and last up to two weeks.";
        
        Reservation *reservationThree = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.managedObjectContext];
        
        reservationThree.dateInStringFormat = @"Monday, March 26, 2017";
        reservationThree.time = @"6:00 PM";
        reservationThree.serviceName = @"Reflexology";
        reservationThree.partySize = 1;
        reservationThree.partyDuration = @"30M";
        reservationThree.serviceDescription = @"Massage focused on the deepest layer of muscles to tarte knots and release chronic muscle tension.";
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else {
        [self getAllReservations];
    }
    }
    else {
        [self displayAllReservations];
    }
}

- (void)displayAllReservations {
    
    if (self.reservationsArray.count == 0){
        return;
    }
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSMutableString * verticalConstraintString = [NSMutableString stringWithFormat:@"V:|"];
    
    for (int i = 0; i<self.reservationsArray.count; i++) {
        Reservation *reservationObj = [self.reservationsArray objectAtIndex:i];
        
        ReservationView *reservationView = [ReservationView reservationView];
        
        reservationView.dateLabel.text = reservationObj.dateInStringFormat;
        reservationView.timeLabel.text = reservationObj.time;
        reservationView.serviceNameLabel.text = reservationObj.serviceName;
        reservationView.partySize.text = [NSString stringWithFormat:@"PARTY SIZE %d",reservationObj.partySize]
        ;
        reservationView.partyDuration.text = reservationObj.partyDuration;
        reservationView.serviceDetailsLabel.text = reservationObj.serviceDescription;
        
        reservationView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.reservationsContainerView addSubview:reservationView];
        
        NSString * reservationViewKey = [NSString stringWithFormat:@"reservationViewKey_%d", i];
        [verticalConstraintString appendString:[NSString stringWithFormat:@"-15-[%@]",reservationViewKey]];
        
        [dict setObject:reservationView forKey:reservationViewKey];
        
        [self.reservationsContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[%@]-10-|",reservationViewKey] options:0 metrics:0 views:dict]];
        
    }
    
    self.reservationsContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [verticalConstraintString appendString:@"-15-|"];
    [self.reservationsContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintString options:0 metrics:0 views:dict]];
}


@end
