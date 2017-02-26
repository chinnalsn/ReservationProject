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

#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568 || [[UIScreen mainScreen] bounds].size.width == 568)?TRUE:FALSE
#define isiPhone4  ([[UIScreen mainScreen] bounds].size.height == 480 || [[UIScreen mainScreen] bounds].size.width == 480)?TRUE:FALSE
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? YES : NO)

@interface ServicesViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) UIPageViewController *servicesPageViewController;
@property (strong, nonatomic) UIView *selectedPageControlIndicator;
@property (strong, nonatomic) NSArray *tableViewServicesArray;
@property (strong, nonatomic) NSArray *servicesList;

@property (weak, nonatomic) IBOutlet UITableView *servicesTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *servicesTableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *offerLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *massageLabel;
@property (weak, nonatomic) IBOutlet UILabel *offerAvailableOnLabel;
@property (weak, nonatomic) IBOutlet UIButton *reserveButton;
@property (weak, nonatomic) IBOutlet UIView *pageControlContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageControlVerticalCenterConstraint;

@end

@implementation ServicesViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"SPA SERVICE";
    
    [self.reserveButton setEnabled:NO];
    self.servicesTableView.delegate = self;
    self.servicesTableView.dataSource = self;
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
        
        Service *serviceItem = self.servicesList[0];
        [self updateServiceDetails:serviceItem];
    }
    [self setupPageControl];
    [self updatePageControlIndicator:1];
    
    [self.servicesTableView.layer setCornerRadius:15.0];
    [self.reserveButton.layer setCornerRadius:3.0];
    self.reserveButton.userInteractionEnabled = YES;
    
    if (isiPhone4 || isiPhone5) {
        self.servicesTableViewHeightConstraint.constant = 200;
        if (isiPhone4) {
            self.pageControlVerticalCenterConstraint.constant = 20;
        }
    }
    else if (isiPad) {
        self.servicesTableViewHeightConstraint.constant = 300;
    }
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
        self.servicesPageViewController.delegate = self;
    }
}


- (void)setupPageControl
{
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSMutableString * horzontalConstraintString = [NSMutableString stringWithFormat:@"H:|"];
    
    for (int i = 1; i<=self.servicesList.count; i++) {
        
        UIView *pageControlIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [pageControlIndicator setBackgroundColor:[UIColor grayColor]];
        
        pageControlIndicator.layer.cornerRadius = 5;
        pageControlIndicator.tag = i;
        pageControlIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        [self.pageControlContainer addSubview:pageControlIndicator];
        
        NSString * pageControlIndicatorKey = [NSString stringWithFormat:@"pageControlIndicatorKey_%d", i];
        [horzontalConstraintString appendString:[NSString stringWithFormat:@"-3-[%@(==10)]",pageControlIndicatorKey]];
        
        [dict setObject:pageControlIndicator forKey:pageControlIndicatorKey];
        
        [self.pageControlContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-3-[%@(==10)]",pageControlIndicatorKey] options:0 metrics:0 views:dict]];
        
        
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
        pageItemController.imageName = serviceItem.imageName;
        return pageItemController;
    }
    
    return nil;
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{

    if (completed) {
        
        NSUInteger currentIndex = ((ServicePageItemViewController *)self.servicesPageViewController.viewControllers.firstObject).itemIndex;
        Service *serviceItem = self.servicesList[currentIndex];
        [self updateServiceDetails:serviceItem];
        [self updatePageControlIndicator:currentIndex+1];
    }
}

- (void)updateServiceDetails:(Service *)serviceItem {
    self.offerLabel.text = serviceItem.offer;
    self.serviceNameLabel.text = serviceItem.serviceName;
    self.massageLabel.text = @"MASSAGE";
    self.offerAvailableOnLabel.text = serviceItem.offerAvailableOn;
    
    if ([[serviceItem.serviceName lowercaseString] isEqualToString:@"hot stone"]) {
        [self.reserveButton setEnabled:YES];
    }
    else {
        [self.reserveButton setEnabled:NO];
    }
}

- (void)updatePageControlIndicator:(NSInteger) tag {
    UIView *pageControlIndicator = [self.pageControlContainer viewWithTag:tag];
    if (self.selectedPageControlIndicator) {
        self.selectedPageControlIndicator.backgroundColor = [UIColor grayColor];
    }
    if (pageControlIndicator) {
        pageControlIndicator.backgroundColor = [UIColor whiteColor];
        self.selectedPageControlIndicator = pageControlIndicator;
    }
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
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size:15.0f];
    cell.textLabel.textColor = [UIColor colorWithRed:15/255 green:20/255 blue:46/255 alpha:1];
    cell.textLabel.adjustsFontSizeToFitWidth=YES;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = false;
    cell.separatorInset = UIEdgeInsetsZero;
    
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
    
    return self.servicesTableViewHeightConstraint.constant/5;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     Reservation option available only for the hot stone massage
     */
    if (indexPath.row == 2) {
         [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self goToReservation];
    }
}

/*
    reserve button action (this method called only for hot stone massage
 */
- (IBAction)reserveButtonAction:(id)sender {
    [self goToReservation];
}

/*
   Navigate to the reservation view controller
 */
- (void)goToReservation {
    ReservationViewController *reservationViewController = (ReservationViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ReservationViewController"];
    
    [self.navigationController pushViewController:reservationViewController animated:YES];
    
}


@end
