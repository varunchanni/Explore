//
//  CityMissionViewController.m
//  Explore
//
//  Created by Varun on 14/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "CityMissionViewController.h"
#import "MissionsViewController.h"
#import "FeedViewController.h"

#import "AdminMissionCategoryViewController.h"

@interface CityMissionViewController () <UIPickerViewDataSource, UIPickerViewDelegate> {
    
    __weak IBOutlet UIImageView *imgViewUser;
    __weak IBOutlet UILabel *lblWelcomeUser;
    __weak IBOutlet UITextField *txtFieldSelectCity;
    __weak IBOutlet UIButton *btnStart;
    __weak IBOutlet UIView *viewTextBack;
    __weak IBOutlet UIPickerView *pickerCity;
    __weak IBOutlet UIVisualEffectView *viewBlurBtns;
    __weak IBOutlet UIView *viewAdmin;
    __weak IBOutlet UIView *viewCenterButtons;
}

@end

@implementation CityMissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupCitySelectView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [viewAdmin setHidden:YES];
    [self enablePanMode:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup View

- (void)setupCitySelectView {
    
    [self setTitle:@"EƎxplore"];
    
    for (UIButton *button in viewCenterButtons.subviews) {
        [button.layer setCornerRadius:4.f];
    }
    
//    NSUserDefaults *userDefs = [NSUserDefaults standardUserDefaults];
//    
//    if ([[userDefs objectForKey:_EX_UDKeyUType] isEqualToString:@"Admin"]) {
//        
//        [viewAdmin setHidden:NO];
//        for (UIButton *button in viewCenterButtons.subviews) {
//            [button.layer setCornerRadius:4.f];
//        }
//    }
//    else {
    
        [btnStart.layer setCornerRadius:4.f];
        [btnStart setBackgroundColor:[UIColor whiteColor]];
        
        [viewTextBack.layer setCornerRadius:5.f];
        
        [txtFieldSelectCity setInputView:pickerCity];
        
        [self setupInputViewForTextField];
        
        UIImageView *imgViewTextRight = [[UIImageView alloc] initWithFrame:CGRectMake(11, 0, 12, 35)];
        [imgViewTextRight setContentMode:UIViewContentModeScaleAspectFit];
        [imgViewTextRight setImage:[UIImage imageNamed:@"dropdown_city"]];
        
        UIView *viewRight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        [viewRight setBackgroundColor:[UIColor clearColor]];
        [viewRight addSubview:imgViewTextRight];
        
        [txtFieldSelectCity setRightView:viewRight];
        [txtFieldSelectCity setRightViewMode:UITextFieldViewModeAlways];
        
        imgViewTextRight = nil;
        viewRight = nil;
        
        for (UIButton *button in viewBlurBtns.contentView.subviews) {
            [button.layer setBorderColor:[UIColor whiteColor].CGColor];
            [button.layer setBorderWidth:0.25f];
        }
//    }
}

- (void)setupInputViewForTextField {
    
    CGSize sizeScreen = [UIScreen mainScreen].bounds.size;
    
    UIView *inputViewForTextField = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeScreen.width, 200)];
    [inputViewForTextField setBackgroundColor:[UIColor whiteColor]];
    
    UIView *viewAcc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeScreen.width, 38)];
    [viewAcc setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lblMissionInfo = [[UILabel alloc] initWithFrame:CGRectMake(20, 2, sizeScreen.width - 70, 34)];
    [lblMissionInfo setFont:[UIFont systemFontOfSize:20]];
    [lblMissionInfo setTextColor:[UIColor blackColor]];
    [lblMissionInfo setText:@"Select a city from list"];
    
    UIButton *buttonToResign = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonToResign setFrame:CGRectMake(sizeScreen.width - 70, 3, 60, 32)];
    [buttonToResign setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonToResign setTitle:@"Done" forState:UIControlStateNormal];
    [buttonToResign addTarget:self
                       action:@selector(doneButtonTouched:)
             forControlEvents:UIControlEventTouchUpInside];
    [buttonToResign.layer setBorderColor:[UIColor blackColor].CGColor];
    [buttonToResign.layer setBorderWidth:1.0f];
    
    [viewAcc addSubview:lblMissionInfo];
    [viewAcc addSubview:buttonToResign];
    lblMissionInfo = nil;
    
    [viewAcc.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [viewAcc.layer setShadowOffset:CGSizeMake(0, 1)];
    [viewAcc.layer setShadowOpacity:0.25f];
    [viewAcc.layer setShadowRadius:0.8f];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 38, sizeScreen.width, 162)];
    [pickerView setDelegate:self];
    [pickerView setDataSource:self];
    
    [inputViewForTextField addSubview:viewAcc];
    [inputViewForTextField addSubview:pickerView];
    [txtFieldSelectCity setInputView:inputViewForTextField];
    pickerView = nil;
    viewAcc = nil;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Admin Buttons

- (IBAction)buttonForAdminTouched:(id)sender {
    
    if ([sender tag] < 3) {
        
        [self enablePanMode:NO];
        
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

#pragma mark - Start Tapped

- (IBAction)buttonStatusesTouchedAction:(id)sender {
    
    FeedViewController *objFeedView = (FeedViewController *)[self.storyboard instantiateViewControllerWithIdentifier:_EX_IDFeedViewStrbrdID];
    [self.navigationController pushViewController:objFeedView animated:YES];
}

- (IBAction)buttonPicturesTouchedAction:(id)sender {
}

- (IBAction)buttonStartTapped:(id)sender {
    
    MissionsViewController *objMissionsView = (MissionsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:_EX_IDMissionsViewStrbrd];
    [self.navigationController pushViewController:objMissionsView animated:YES];
    
}

- (IBAction)buttonAdminTouched:(id)sender {
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [viewAdmin setHidden:NO];
    [self setTitle:@""];
}

- (void)doneButtonTouched:(id)sender {
    [txtFieldSelectCity resignFirstResponder];
}

#pragma mark - UIPickerView Delegate & DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [NSString stringWithFormat:@"City %ld", (long)row];
}

@end
