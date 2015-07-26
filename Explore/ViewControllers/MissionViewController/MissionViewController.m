//
//  MissionViewController.m
//  Explore
//
//  Created by Varun on 3/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "MissionViewController.h"
#import "MissionOptionCell.h"
#import "MissionDoneViewController.h"

static NSString *REUSEOptionCell = @"ReuseOptionCell";

@interface MissionViewController () <UITableViewDataSource, UITableViewDelegate> {
    
    __weak IBOutlet UITableView *tblMissionOptions;
    __weak IBOutlet UIButton *btnSubmit;
    
    NSArray *arrOptions;
    NSArray *arrImages;
}

@end

@implementation MissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupMissionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Mission View

- (void)setupMissionView {
    
    [self setTitle:@"Your Mission"];
    
    arrOptions = [[NSArray alloc] initWithObjects:
                  @"Upload a picture",
                  @"Check-in",
                  @"Answer a question", nil];
    arrImages = [[NSArray alloc] initWithObjects:
                 @"upload_pic",
                 @"checkin",
                 @"answer_ques", nil];
    
    UINib *nibCellOption = [UINib nibWithNibName:@"MissionOptionCell" bundle:nil];
    [tblMissionOptions registerNib:nibCellOption forCellReuseIdentifier:REUSEOptionCell];
    
    if ([tblMissionOptions respondsToSelector:@selector(setSeparatorInset:)]) {
        [tblMissionOptions setSeparatorInset:UIEdgeInsetsMake(0, 60, 0, 0)];
    }
    
    if ([tblMissionOptions respondsToSelector:@selector(setLayoutMargins:)]) {
        [tblMissionOptions setLayoutMargins:UIEdgeInsetsMake(0, 60, 0, 0)];
    }
    
    [btnSubmit.layer setCornerRadius:4.f];
    [btnSubmit setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - IBAction Submit

- (IBAction)buttonSubmitAction:(id)sender {
    
    MissionDoneViewController *objMissionDoneView = (MissionDoneViewController *)[self.storyboard instantiateViewControllerWithIdentifier:_EX_IDMssonDoneStrbrdID];
    [self.navigationController pushViewController:objMissionDoneView animated:YES];
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MissionOptionCell *cellMissionOption = (MissionOptionCell *)[tableView dequeueReusableCellWithIdentifier:REUSEOptionCell];
    [cellMissionOption setCellContentWithText:arrOptions[indexPath.row] andImage:arrImages[indexPath.row]];
    
    UIView *viewSelection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 50)];
    [viewSelection setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.4f]];
    [cellMissionOption setSelectedBackgroundView:viewSelection];
    
    return cellMissionOption;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
