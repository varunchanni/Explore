//
//  AboutUsViewController.m
//  Explore
//
//  Created by Varun on 30/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController () {
    
    __weak IBOutlet UITextView *txtViewAboutUs;
}

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"About Us"];
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

@end
