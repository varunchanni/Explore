//
//  MissionDoneViewController.m
//  Explore
//
//  Created by Varun on 13/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "MissionDoneViewController.h"

@interface MissionDoneViewController () {
    
    __weak IBOutlet UILabel *lblCompleteMission;
    __weak IBOutlet UIButton *btnAnotherMission;
}

@end

@implementation MissionDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupMissionDoneView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup View

- (void)setupMissionDoneView {
    
    [self setTitle:@"Mission Complete"];
    [self setPopToRootView:YES];
    
    [btnAnotherMission.layer setCornerRadius:4.f];
    [btnAnotherMission setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - IBAction
- (IBAction)buttonReadyForAnotherMissionTapped:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
