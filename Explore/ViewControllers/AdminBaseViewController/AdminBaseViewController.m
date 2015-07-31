//
//  AdminBaseViewController.m
//  Explore
//
//  Created by Varun on 31/07/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "AdminBaseViewController.h"

@interface AdminBaseViewController ()

@end

@implementation AdminBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
    UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
    
    [EXUserDefs setObject:getImagePath forKey:@"BackImage"];
    [EXUserDefs synchronize];
    
    UIImageView *imgViewBack = (UIImageView *)[self.view viewWithTag:1000];
    [imgViewBack setImage:img ? img : [UIImage imageNamed:@"background"]];
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
