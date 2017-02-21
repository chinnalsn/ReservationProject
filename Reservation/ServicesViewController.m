//
//  ServicesViewController.m
//  Reservation
//
//  Created by Chinna on 2/17/17.
//  Copyright © 2017 Chinna. All rights reserved.
//

#import "ServicesViewController.h"
#import "ServicePageItemViewController.h"
#import "Service.h"
#import "ReservationViewController.h"
#import "ionicons/IonIcons.h"

@interface ServicesViewController () <UIPageViewControllerDataSource, UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UIPageViewController *servicesPageViewController;
@property (weak, nonatomic) IBOutlet UITableView *servicesTableView;
@property (nonatomic, strong) NSArray *tableViewServicesArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *servicesTableViewHeightConstraint;

@property (strong, nonatomic) NSArray *servicesList;

@property (weak, nonatomic) IBOutlet UILabel *offerLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *massageLabel;
@property (weak, nonatomic) IBOutlet UILabel *offerAvailableOnLabel;
@property (weak, nonatomic) IBOutlet UIButton *reserveButton;

@property (weak, nonatomic) IBOutlet UIView *pageControlContainer;


@end

@implementation ServicesViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"SPA SERVICE";
    
    self.servicesTableView.delegate = self;
    self.servicesTableView.dataSource = self;
    
    self.servicesTableView.estimatedRowHeight = 100;
    self.servicesTableView.rowHeight = UITableViewAutomaticDimension;
    self.servicesTableView.backgroundColor = [UIColor clearColor];
    
    
    self.tableViewServicesArray = @[@"Swedish Massage", @"Deep Tissue Massage", @"Hot Stone Massage", @"Reflexology", @"Trigger Point Therapy"];
    
    [self getServiceInfo];
    
    if([self.servicesList count])
    {
        NSArray *startingViewControllers = @[[self itemControllerForIndex:0]];
        [self.servicesPageViewController setViewControllers:startingViewControllers
                                                  direction:UIPageViewControllerNavigationDirectionForward
                                                   animated:NO
                                                 completion:nil];
    }
    [self setupPageControl];
    
    [self.servicesTableView.layer setCornerRadius:15.0];
    
    self.offerLabel.font = [IonIcons fontWithSize:40.0f];
    self.serviceNameLabel.font = [IonIcons fontWithSize:21.0f];
    self.massageLabel.font = [IonIcons fontWithSize:35.0f];
    self.offerAvailableOnLabel.font = [IonIcons fontWithSize:15.0f];
    [self.reserveButton.layer setCornerRadius:3.0];
    self.reserveButton.userInteractionEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)getServiceInfo {
    Service *mothersDayService = [[Service alloc] initWithOffer:@"$50 OFF" service:@"Mother's Day" available:@"AVAILABLE MAY 1 - 16" imageName:@"service2.jpg"];
    Service *hotStoneService = [[Service alloc] initWithOffer:@"20% OFF" service:@"Hot Stone" available:@"AVAILABLE MAY 1 - 16" imageName:@"service3.jpg"];
    Service *deepTissueService = [[Service alloc] initWithOffer:@"10% OFF" service:@"Deep Tissue" available:@"AVAILABLE APRIL 10 - 28" imageName:@"service1.jpg"];
    
    self.servicesList = @[mothersDayService, hotStoneService, deepTissueService];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * segueName = segue.identifier;
    segue.destinationViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    if ([segueName isEqualToString: @"ServicesPageViewController"]) {
        self.servicesPageViewController = (UIPageViewController *) [segue destinationViewController];
        self.servicesPageViewController.dataSource = self;
        
    }
}


- (void)setupPageControl
{
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSMutableString * horzontalConstraintString = [NSMutableString stringWithFormat:@"H:|"];
    
    for (int i = 0; i<self.servicesList.count; i++) {
        
        UIView *pageControlIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [pageControlIndicator setBackgroundColor:[UIColor whiteColor]];
        
        pageControlIndicator.layer.cornerRadius = 5;
        pageControlIndicator.tag = i;
        pageControlIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        [self.pageControlContainer addSubview:pageControlIndicator];
        
        NSString * pageControlIndicatorKey = [NSString stringWithFormat:@"pageControlIndicatorKey_%d", i];
        [horzontalConstraintString appendString:[NSString stringWithFormat:@"-3-[%@(==10)]",pageControlIndicatorKey]];
        
        [dict setObject:pageControlIndicator forKey:pageControlIndicatorKey];
        
        [self.pageControlContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-3-[%@(==10)]-0-|",pageControlIndicatorKey] options:0 metrics:0 views:dict]];
        
    }
    
    self.pageControlContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [horzontalConstraintString appendString:@"-0-|"];
    [self.pageControlContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horzontalConstraintString options:0 metrics:0 views:dict]];
}

#pragma mark UIPageViewControllerDataSource


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    ServicePageItemViewController *itemController = (ServicePageItemViewController *)viewController;
    
    NSUInteger index = itemController.itemIndex;
    
    if (index == 0 || index == NSNotFound)
    {
        index = self.servicesList.count;
    }
    else {
        return [self itemControllerForIndex:[self.servicesList count] - 1];
    }
    
    index -= 1;
    return [self itemControllerForIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    ServicePageItemViewController *itemController = (ServicePageItemViewController *)viewController;
    
    NSUInteger index = itemController.itemIndex;
    
    if (index == NSNotFound) {
        return nil;
    };
    
    index += 1;
    
    if (index == self.servicesList.count) {
        index = 0;
    };
    
    return [self itemControllerForIndex:index];
}

- (ServicePageItemViewController *)itemControllerForIndex:(NSUInteger)itemIndex
{
    if (itemIndex < [self.servicesList count])
    {
        ServicePageItemViewController *pageItemController = [self.storyboard instantiateViewControllerWithIdentifier:@"ServicePageItemViewController"];
        pageItemController.itemIndex = itemIndex;
        Service *serviceItem = self.servicesList[itemIndex];
        
        self.offerLabel.text = serviceItem.offer;
        self.serviceNameLabel.text = serviceItem.serviceName;
        self.massageLabel.text = @"MASSAGE";
        self.offerAvailableOnLabel.text = serviceItem.offerAvailableOn;
        
        pageItemController.imageName = serviceItem.imageName;
        return pageItemController;
    }
    
    return nil;
}

#pragma mark - Additions

- (NSUInteger)currentControllerIndex
{
    ServicePageItemViewController *pageItemController = (ServicePageItemViewController *) [self currentController];
    
    if (pageItemController)
    {
        return pageItemController.itemIndex;
    }
    
    return -1;
}

- (UIViewController *)currentController
{
    if ([self.servicesPageViewController.viewControllers count])
    {
        return self.servicesPageViewController.viewControllers[0];
    }
    
    return nil;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableViewServicesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *serviceTableViewCellIdentifier = @"serviceTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:serviceTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:serviceTableViewCellIdentifier];
    }
    
    cell.textLabel.text = [self.tableViewServicesArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [IonIcons fontWithSize:20.0f];
    
    if (indexPath.row == 2) {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.userInteractionEnabled = YES;
    }
    else {
        cell.userInteractionEnabled = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        [self goToReservation];
    }
}

- (IBAction)reserveButtonAction:(id)sender {
    [self goToReservation];
}



- (void)goToReservation {
    ReservationViewController *reservationViewController = (ReservationViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ReservationViewController"];
    
    [self.navigationController pushViewController:reservationViewController animated:YES];
    
}



@end
