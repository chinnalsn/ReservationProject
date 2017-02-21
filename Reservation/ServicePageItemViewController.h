//
//  ServicePageItemViewController.h
//  Reservation
//
//  Created by Chinna on 2/17/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicePageItemViewController : UIViewController

// Item controller information
@property (nonatomic) NSUInteger itemIndex; // ***
@property (nonatomic, strong) NSString *imageName; // ***

@property (weak, nonatomic) IBOutlet UIImageView *servicePageItemBackgroundImageView;

@end
