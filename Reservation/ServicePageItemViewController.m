//
//  ServicePageItemViewController.m
//  Reservation
//
//  Created by Chinna on 2/17/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "ServicePageItemViewController.h"

@interface ServicePageItemViewController ()


@end

@implementation ServicePageItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.servicePageItemBackgroundImageView.image = [UIImage imageNamed: self.imageName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
