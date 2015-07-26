//
//  LoginViewController.m
//  Explore
//
//  Created by Varun on 13/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController () <UITextFieldDelegate> {
    
    __weak IBOutlet EXTextField *txtFieldUsername;
    __weak IBOutlet EXTextField *txtFieldPassword;
    __weak IBOutlet UIButton *btnLogin;
    __weak IBOutlet UIButton *btnSignup;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self setupLoginView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup View Defaults

- (void)setupLoginView {
    
    [EXAppFunctions setImageForLeftView:@"username" forTextField:txtFieldUsername];
    [EXAppFunctions setImageForLeftView:@"password" forTextField:txtFieldPassword];
    
    [btnLogin.layer setCornerRadius:4.f];
    [btnSignup.layer setCornerRadius:4.f];
    
    [btnLogin setBackgroundColor:[UIColor whiteColor]];
    [btnSignup.layer setBorderColor:[UIColor whiteColor].CGColor];
    [btnSignup.layer setBorderWidth:1.f];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TextField Delegates

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    return ![string isEqualToString:@" "];
}

#pragma mark - Other Methods

- (NSString *)userLoginCheckErrorMessage {
    
    BOOL validEnteries = YES;
    
    NSString *strUsername = txtFieldUsername.text;
    NSString *strPassword = txtFieldPassword.text;
    
    NSString *strErrorMessage = @"";
    
    if ([strUsername length] < 6) {
        strErrorMessage = @"Username too short, has to be atleast six characters.";
        validEnteries = NO;
    }
    else if (validEnteries && [strPassword length] < 6) {
        strErrorMessage = @"Password too short, has to be atleast six characters.";
        validEnteries = NO;
    }
    return strErrorMessage;
}

#pragma mark - IBActions

- (IBAction)buttonForgotPasswordAction:(id)sender {
}

- (IBAction)buttonLoginTouchAction:(id)sender {
    
    NSString *errorMessage = [self userLoginCheckErrorMessage];
    if (![errorMessage length]) {
        
        NSString *strEmail = txtFieldUsername.text;
        NSString *strPassword = txtFieldPassword.text;
        
        NSDictionary *dictSignup = [NSDictionary dictionaryWithObjectsAndKeys:
                                    strEmail, @"email",
                                    strPassword, @"password", nil];
        
        UIView *viewLoading = [EXAppFunctions showLoadingViewWithText:nil];
        
        NSString *strURL = [EXAppFunctions stringURLForFunction:_EX_WSLogin];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager POST:strURL parameters:dictSignup success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *responseDict = (NSDictionary *)responseObject;
            NSLog(@"Response Dict : %@", responseDict);

            [EXAppFunctions hideLoadingView:viewLoading];
            if ([[responseDict objectForKey:_EX_RSKeyError] intValue]) {
                
                [EXUserDefs setBool:YES forKey:_EX_UDKeyLogin];
                [EXUserDefs synchronize];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                [EXAppFunctions showAlertWithTitle:@"Login Error"
                                       withMessage:[responseDict objectForKey:_EX_RSKeyMessage]];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [EXAppFunctions unexpectedErrorWithLoadingView:viewLoading];
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [EXAppFunctions showAlertWithTitle:@"Incorrect Parameters"
                               withMessage:errorMessage];
    }
}

- (IBAction)buttonSignupTouchedAction:(id)sender {
}

- (IBAction)buttonSignInWithFacebookTouched:(id)sender {
    
    UIView *viewLogin = [EXAppFunctions showLoadingViewWithText:nil];
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        [EXAppFunctions hideLoadingView:viewLogin];
        if (error) {
            // Process error
            [EXAppFunctions showAlertWithTitle:@"Facebook Login"
                                   withMessage:@"Error processing login request"];
        } else if (result.isCancelled) {
            // Handle cancellations
            [EXAppFunctions showAlertWithTitle:@"Facebook Login"
                                   withMessage:@"User cancelled the login."];
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"email"]) {
                // Do work
                [EXAppFunctions showAlertWithTitle:@"Facebook Login"
                                       withMessage:@"The login is successful."];

                [EXUserDefs setBool:YES forKey:_EX_UDKeyLogin];
                [EXUserDefs synchronize];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
}

#pragma mark - Touches

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    UIView *viewTouched = [[touches anyObject] view];
    if (![viewTouched isKindOfClass:[UITextField class]]) {
        [txtFieldUsername resignFirstResponder];
        [txtFieldPassword resignFirstResponder];
    }
}

@end
