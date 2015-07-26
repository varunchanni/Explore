//
//  AboutMissionViewController.m
//  Explore
//
//  Created by Varun on 11/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "AboutMissionViewController.h"
#import "MissionViewController.h"

@interface AboutMissionViewController () {
    
    __weak IBOutlet UIImageView *imgViewMission;
    __weak IBOutlet UIView *viewMissionButtons;
    __weak IBOutlet UILabel *lblMissionInfo;
    __weak IBOutlet UIButton *btnContribute;
    
    NSInteger selectedTag;
}

@end

@implementation AboutMissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupAboutMissionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup View

- (void)setupAboutMissionView {
    
    [self setTitle:@"About the Mission"];
    
    for (UIButton *button in viewMissionButtons.subviews) {
        // the space between the image and text
        CGFloat spacing = 8.0;
        
        // lower the text and push it left so it appears centered
        //  below the image
        CGSize imageSize = button.imageView.image.size;
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
        
        // raise the image and push it right so it appears centered
        //  above the text
        CGSize titleSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
        button.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
        
        [button.layer setBorderColor:[UIColor darkGrayColor].CGColor];
        [button.layer setBorderWidth:0.25f];
    }
    
    [viewMissionButtons.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [viewMissionButtons.layer setBorderWidth:0.25f];
    
    [btnContribute.layer setCornerRadius:4.f];
    [btnContribute setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *buttonInfo = (UIButton *)[viewMissionButtons viewWithTag:1];
    [self buttonInMissionViewTapped:buttonInfo];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBAction Mission View Buttons

- (IBAction)buttonInMissionViewTapped:(UIButton *)sender {
    for (UIButton *button in viewMissionButtons.subviews) {
        if (button.tag == sender.tag) {
            button.selected = YES;
            selectedTag = button.tag;
        }
        else {
            button.selected = NO;
        }
    }
}

#pragma mark - IBAction Contribute Mission

- (IBAction)buttonContributeToMissionTapped:(id)sender {
    
    MissionViewController *objMissionView = (MissionViewController *)[self.storyboard instantiateViewControllerWithIdentifier:_EX_IDMssonStrbrdID];
    [self.navigationController pushViewController:objMissionView animated:YES];

}

@end
