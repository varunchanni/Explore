//
//  ViewController.m
//  Explore
//
//  Created by Varun on 10/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "FeedViewController.h"
#import "LoginViewController.h"
#import "FeedViewCell.h"
#import "CityMissionViewController.h"

NSString *const REUSEFEEDCELLID = @"ReuseIDFeedCell";

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate> {
    
    __weak IBOutlet UITableView *tblViewFeed;
    __weak IBOutlet UIView *viewSegment;
    __weak IBOutlet UIActivityIndicatorView *activitySpinner;
}

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupHomeViewDefaults];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![EXUserDefs boolForKey:_EX_UDKeyLogin]) {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:_EX_IDMainStrbrd
                                                                 bundle:nil];
        LoginViewController *objLoginView = (LoginViewController *)[mainStoryBoard instantiateViewControllerWithIdentifier:_EX_IDLoginStrbrd];
        [self.navigationController presentViewController:objLoginView animated:NO
                                              completion:nil];
    }
    else {
        [tblViewFeed setHidden:NO];
        [viewSegment setHidden:NO];
        [activitySpinner stopAnimating];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Home View Defaults

- (void)setupHomeViewDefaults {
    
    [self setTitle:@"Dashboard"];
    
    [tblViewFeed registerNib:[UINib nibWithNibName:@"FeedViewCell" bundle:nil]
      forCellReuseIdentifier:REUSEFEEDCELLID];
    
    for (UIButton *button in viewSegment.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            [button.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [button.layer setBorderWidth:0.5f];
        }
    }
}

#pragma mark - IBAction Top Buttons

- (IBAction)buttonTopButtonActions:(id)sender {

    if ([sender tag] == 1) {
        
        CityMissionViewController *objCityMissionView = (CityMissionViewController *)[self.storyboard instantiateViewControllerWithIdentifier:_EX_IDCityMissionStrbrd];
        [self.navigationController pushViewController:objCityMissionView animated:YES];
        
//        MissionDoneViewController *objMissionDoneView = (MissionDoneViewController *)[self.storyboard instantiateViewControllerWithIdentifier:_EX_IDMssonDoneStrbrdID];
//        [self.navigationController pushViewController:objMissionDoneView animated:YES];
    }
    else {
        
    }
}

#pragma mark - UITableView Delegate and DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedViewCell *cellFeed = [tableView dequeueReusableCellWithIdentifier:REUSEFEEDCELLID];
    return cellFeed;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
