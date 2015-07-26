//
//  LeftMenuViewController.m
//  Explore
//
//  Created by Varun on 20/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuCell.h"
#import "AppDelegate.h"

static NSString *REUSEMenuCell = @"ReuseMenuCell";

@interface LeftMenuViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    __weak IBOutlet UITableView *tblViewMenu;
    __weak IBOutlet UIView *viewUpper;
    
    NSDictionary *dictMenuItems;
    UIColor *colorOrange;
    NSIndexPath *indexPathSelected;
}

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLeftMenuDefaults];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLeftMenuDefaults {
    
    NSDictionary *dictDashboard = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"Dashboard", @"menuItem",
                                   @"dashboard", @"menuImage", nil];
    NSDictionary *dictProfile = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"My Profile", @"menuItem",
                                 @"profile", @"menuImage", nil];
//    NSDictionary *dictMission = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 @"Missions", @"menuItem",
//                                 @"mission", @"menuImage", nil];
//    NSDictionary *dictCityMssns = [NSDictionary dictionaryWithObjectsAndKeys:
//                                   @"City Missions", @"menuItem",
//                                   @"city", @"menuImage", nil];
    NSDictionary *dictCoupons = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Coupons", @"menuItem",
                                 @"coupon", @"menuImage", nil];
    NSDictionary *dictAboutUs = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"About Us", @"menuItem",
                                 @"about", @"menuImage", nil];
    
    dictMenuItems = [NSDictionary dictionaryWithObjectsAndKeys:
                     dictDashboard, @"0",
                     dictProfile, @"1",
//                     dictMission, @"2",
//                     dictCityMssns, @"3",
                     dictCoupons, @"2",
                     dictAboutUs, @"3", nil];
    
    indexPathSelected = [NSIndexPath indexPathForRow:0 inSection:0];
    colorOrange = [UIColor colorWithRed:1.0f green:0.5f blue:0.0f alpha:1.0f];
    
    UINib *nibLeftMenuCell = [UINib nibWithNibName:@"LeftMenuCell" bundle:nil];
    [tblViewMenu registerNib:nibLeftMenuCell forCellReuseIdentifier:REUSEMenuCell];
    
    [viewUpper.layer setShadowColor:[UIColor darkGrayColor].CGColor];
    [viewUpper.layer setShadowOffset:CGSizeMake(0, 0.5)];
    [viewUpper.layer setShadowOpacity:0.5f];
    [viewUpper.layer setShadowRadius:1];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section ? 1 : [[dictMenuItems allKeys] count]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section ? 10 : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeftMenuCell *cellMenu = [tableView dequeueReusableCellWithIdentifier:REUSEMenuCell];
    
    NSDictionary *dictAtIndex = [dictMenuItems objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    
    NSDictionary *dictLogout = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"Logout", @"menuItem",
                                @"logout", @"menuImage", nil];
    
    UIView *viewSelBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 60)];
    [viewSelBack setBackgroundColor:colorOrange];
    [cellMenu setSelectedBackgroundView:viewSelBack];
    
    UIColor *color = nil;
    if (indexPath == indexPathSelected) {
        color = colorOrange;
    }
    [cellMenu setColorForLabel:color];
    
    [cellMenu setMenuItemWithDict:(indexPath.section) ? dictLogout : dictAtIndex];
    return cellMenu;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController *navController = nil;
    
    switch (indexPath.row) {
        case 0:
            navController = [self.storyboard instantiateViewControllerWithIdentifier:_EX_IDMainNavStrbrd];
            break;
        case 1:
            navController = [self.storyboard instantiateViewControllerWithIdentifier:_EX_IDPrfleNavStrbrdID];
            break;
//        case 2:
//            navController = [self.storyboard instantiateViewControllerWithIdentifier:_EX_IDMissionNavStrbrd];
//            break;
//        case 3:
//            navController = [self.storyboard instantiateViewControllerWithIdentifier:_EX_IDCityMissionNavStrbrd];
//            break;
        case 2:
            navController = [self.storyboard instantiateViewControllerWithIdentifier:_EX_IDCupnsNavStrbrdID];
            break;
        case 3:
            navController = [self.storyboard instantiateViewControllerWithIdentifier:_EX_IDAboutUsNavStrbrdID];
            break;
        default:
            return;
            break;
    }
    
    [appDelegate.container setCenterViewController:navController];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [appDelegate.container setMenuState:MFSideMenuStateClosed];
    
    indexPathSelected = indexPath;
    [tableView performSelector:@selector(reloadData) withObject:nil afterDelay:1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
