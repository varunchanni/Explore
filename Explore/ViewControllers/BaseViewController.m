//
//  BaseViewController.m
//  Explore
//
//  Created by Varun on 20/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "BaseViewController.h"
#import "MFSideMenu.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if ([[self.navigationController viewControllers] count] == 1) {
        
        UIBarButtonItem *barButtonLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeftMenuPressed)];
        [self.navigationItem setLeftBarButtonItem:barButtonLeft];
    }
    else {
        UIBarButtonItem *barButtonLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
        [self.navigationItem setLeftBarButtonItem:barButtonLeft];
    }
    
    UIBarButtonItem *barButtonRight = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(showRightMenuPressed)];
    [self.navigationItem setRightBarButtonItem:barButtonRight];
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

- (void)enablePanMode:(BOOL)enable {
    [self.menuContainerViewController setPanMode:((enable) ? MFSideMenuPanModeDefault : MFSideMenuPanModeNone)];
}

- (void)showLeftMenuPressed {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (void)showRightMenuPressed {
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
}

- (void)backButtonPressed {
//    if ([self.menuContainerViewController menuState] == MFSideMenuStateClosed)
    SEL popViewController = self.popToRootView ? @selector(popToRootViewControllerAnimated:) : @selector(popViewControllerAnimated:);
    [self.navigationController performSelector:popViewController
                                    withObject:[NSNumber numberWithBool:YES]];
//    else
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

@end
