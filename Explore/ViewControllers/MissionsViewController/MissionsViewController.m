//
//  MissionsViewController.m
//  Explore
//
//  Created by Varun on 2/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "MissionsViewController.h"
#import "MissionViewController.h"
#import "MissionsTableCell.h"
#import "AboutMissionViewController.h"

static NSString *REUSEMssnTblCell = @"ReuseMissionTableCell";

@interface MissionsViewController () <UITableViewDataSource, UITableViewDelegate, MissionTableDelegate> {
    
    __weak IBOutlet UITableView *tableViewMissions;
}

@end

@implementation MissionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupMissionsViewDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set View Defaults

- (void)setupMissionsViewDefault {
    
    [self setTitle:@"Missions"];
    
    UINib *tableCellNib = [UINib nibWithNibName:@"MissionsTableCell" bundle:nil];
    [tableViewMissions registerNib:tableCellNib forCellReuseIdentifier:REUSEMssnTblCell];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MissionsTableCell *cellMissions = [tableView dequeueReusableCellWithIdentifier:REUSEMssnTblCell];
    [cellMissions setDelegate:self];
    return cellMissions;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Mission Table Cell Delegate

- (void)didSelectTheCollectionCellAtIndex:(NSIndexPath *)indexPath {
    
//    AboutMissionViewController *objAbtMissionView = (AboutMissionViewController *)[self.storyboard instantiateViewControllerWithIdentifier:_EX_IDAbtMssonStrbrdID];
//    [self.navigationController pushViewController:objAbtMissionView animated:YES];
    
    MissionViewController *objMissionView = (MissionViewController *)[self.storyboard instantiateViewControllerWithIdentifier:_EX_IDMssonStrbrdID];
    [self.navigationController pushViewController:objMissionView animated:YES];

}

- (void)infoButtonTappedOnMissionCell {
    
    AboutMissionViewController *objAbtMissionView = (AboutMissionViewController *)[self.storyboard instantiateViewControllerWithIdentifier:_EX_IDAbtMssonStrbrdID];
    [self.navigationController pushViewController:objAbtMissionView animated:YES];
}

@end
