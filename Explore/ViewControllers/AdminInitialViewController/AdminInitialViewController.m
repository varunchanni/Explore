//
//  AdminInitialViewController.m
//  Explore
//
//  Created by Varun on 31/07/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "AdminInitialViewController.h"
#import "AdminMissionCategoryViewController.h"

@interface AdminInitialViewController () {
    __weak IBOutlet UIView *viewCenterButtons;
}

@end

@implementation AdminInitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (UIButton *button in viewCenterButtons.subviews) {
        [button.layer setCornerRadius:4.f];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonForAdminTouched:(id)sender {
    
    if ([sender tag] < 3) {
        
//        [self enablePanMode:NO];
        
        AdminMissionCategoryViewController *objAdminMissionCategoryView = (AdminMissionCategoryViewController *)[self.storyboard instantiateViewControllerWithIdentifier:_EX_IDAdminCatMission];
        objAdminMissionCategoryView.adminChoiceType = [sender tag];
        [self.navigationController pushViewController:objAdminMissionCategoryView animated:YES];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"Under Development"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
}

@end
