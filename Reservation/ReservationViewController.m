//
//  ReservationViewController.m
//  Reservation
//
//  Created by Chinna on 2/18/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "ReservationViewController.h"
#import "Reservation+CoreDataClass.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface ReservationViewController ()

@end

@implementation ReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"SCHEDULE";
    self.navigationController.navigationBar.topItem.title = @""; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reserveAction:(id)sender {
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext  *managedObjectContext = delegate.persistentContainer.viewContext;
    
    Reservation *reservationThree = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:managedObjectContext];
    
    reservationThree.dateInStringFormat = @"Monday, March 26, 2017";
    reservationThree.time = @"2:00 PM";
    reservationThree.serviceName = @"Reflexology";
    reservationThree.partySize = 1;
    reservationThree.partyDuration = @"30M";
    reservationThree.serviceDescription = @"Massage focused on the deepest layer of muscles to tarte knots and release chronic muscle tension.";
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

}



@end
