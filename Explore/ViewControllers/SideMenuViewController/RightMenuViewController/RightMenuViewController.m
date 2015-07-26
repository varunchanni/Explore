//
//  RightMenuViewController.m
//  Explore
//
//  Created by Varun on 20/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "RightMenuViewController.h"

@interface RightMenuViewController () <UITableViewDataSource, UITableViewDelegate> {
    
    __weak IBOutlet UIView *viewUpper;
    __weak IBOutlet UITableView *tblViewUsers;
    
    NSString *strFollowFollowing;
}

@end

@implementation RightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRightMenuDefaults];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupRightMenuDefaults {
    
//    [viewUpper.layer setShadowColor:[UIColor darkGrayColor].CGColor];
//    [viewUpper.layer setShadowOffset:CGSizeMake(0, 1)];
//    [viewUpper.layer setShadowOpacity:0.5f];
//    [viewUpper.layer setShadowRadius:5];
    
    strFollowFollowing = @"follower";
    
    for (UIButton *button in self.view.subviews) {
        [button.layer setBorderColor:[UIColor whiteColor].CGColor];
        [button.layer setBorderWidth:0.5];
    }
    
}

#pragma mark - IBAction Follow Following

- (IBAction)buttonFollowFollowingAction:(id)sender {
    strFollowFollowing = [sender tag] == 1 ? @"follower" : @"following";
    [tblViewUsers reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"\t%@ - %ld", strFollowFollowing, (long)indexPath.row]];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
