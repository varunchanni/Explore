//
//  SignupViewController.m
//  Explore
//
//  Created by Varun on 13/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController () <UITextFieldDelegate> {
    
    __weak IBOutlet EXTextField *txtFieldFirstName;
    __weak IBOutlet EXTextField *txtFieldLastName;
    __weak IBOutlet EXTextField *txtFieldEmail;
    __weak IBOutlet EXTextField *txtFieldPassword;
    __weak IBOutlet EXTextField *txtFieldConfirmPassword;
    __weak IBOutlet EXTextField *txtFieldCountry;
    __weak IBOutlet EXTextField *txtFieldMobile;
    __weak IBOutlet UIButton *btnSignup;
    
    CGRect frameDefault;
}

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"Signup"];
    [self setupSignupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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

#pragma mark - Setup View Defaults

- (void)setupSignupView {
    
    frameDefault = self.view.frame;
    
    [btnSignup.layer setCornerRadius:4.f];
    [btnSignup.layer setBorderColor:[UIColor whiteColor].CGColor];
    [btnSignup.layer setBorderWidth:1.f];
}

#pragma mark - Other Methods

- (NSString *)userSignupCheckErrorMessage {
    
    BOOL validEnteries = YES;
    
    NSString *strFirstName = txtFieldFirstName.text;
    NSString *strLastName = txtFieldLastName.text;
    NSString *strEmail = txtFieldEmail.text;
    NSString *strPassword = txtFieldPassword.text;
    NSString *strCPassword = txtFieldConfirmPassword.text;
    
    NSString *strErrorMessage = @"";
    
    if (![strFirstName length]) {
        strErrorMessage = @"First Name cannot be empty";
        validEnteries = NO;
    }
    else if (validEnteries && ![strLastName length]) {
        strErrorMessage = @"Last Name cannot be empty";
        validEnteries = NO;
    }
    else if (validEnteries && ![EXAppFunctions validateEmail:strEmail]) {
        strErrorMessage = @"Email not valid";
        validEnteries = NO;
    }
    else if (validEnteries && [strPassword length] < 6) {
        strErrorMessage = @"Password too short";
        validEnteries = NO;
    }
    else if (validEnteries && (![strPassword isEqualToString:strCPassword])) {
        strErrorMessage = @"Passwords don't match";
        validEnteries = NO;
    }
    
    return strErrorMessage;
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CGRect frameView = frameDefault;
    frameView.origin.y -= textField.tag * textField.frame.size.height - 32;
    [UIView animateWithDuration:0.23f animations:^ {
        [self.view setFrame:frameView];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return ![string isEqualToString:@" "];
}

#pragma mark - IBAction Sign Up

- (IBAction)buttonSignupTouched:(id)sender {
    
    NSString *errorMessage = [self userSignupCheckErrorMessage];
    if (![errorMessage length]) {
        
        NSString *strFirstName = txtFieldFirstName.text;
        NSString *strLastName = txtFieldLastName.text;
        NSString *strEmail = txtFieldEmail.text;
        NSString *strPassword = txtFieldPassword.text;
        NSString *strCountry = txtFieldCountry.text;
        NSString *strMobile = txtFieldMobile.text;
        
        NSDictionary *dictSignup = [NSDictionary dictionaryWithObjectsAndKeys:
                                    strFirstName, @"first_name",
                                    strLastName, @"last_name",
                                    strEmail, @"email",
                                    strPassword, @"password",
                                    strCountry, @"country",
                                    strMobile, @"mobile", nil];
        
        UIView *viewLoading = [EXAppFunctions showLoadingViewWithText:nil];
        
        NSString *strURL = [EXAppFunctions stringURLForFunction:_EX_WSRegister];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager POST:strURL parameters:dictSignup success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [EXAppFunctions hideLoadingView:viewLoading];
            NSDictionary *responseDict = (NSDictionary *)responseObject;
            NSLog(@"JSON: %@", responseDict);
            
            if ([[responseDict objectForKey:_EX_RSKeyError] intValue]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                [EXAppFunctions showAlertWithTitle:@"Signup Error"
                                       withMessage:[responseDict objectForKey:@"message"]];
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

#pragma mark - Touches Ended

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UIView *viewTouched = [[touches anyObject] view];
    if (![viewTouched isKindOfClass:[UITextField class]]) {
        for (UITextField *textField in [self.view viewWithTag:10].subviews)
            [textField resignFirstResponder];
        
        CGRect newFrame = frameDefault;
        newFrame.origin.y += 32;
        [UIView animateWithDuration:0.23f animations:^ {
            [self.view setFrame:newFrame];
        }];
    }
}

@end
