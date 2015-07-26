//
//  AppFunctions.m
//  Explore
//
//  Created by Varun on 10/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "AppFunctions.h"

@implementation AppFunctions

#pragma mark - Shared Instance

+ (id)sharedFunctions {
    static AppFunctions *sharedFunctions = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFunctions = [[self alloc] init];
    });
    return sharedFunctions;
}

#pragma mark - Email Validation

- (CGRect)screenRect {
    return [UIScreen mainScreen].bounds;
}

- (BOOL)validateEmail:(NSString *)email {
    
    NSString *emailRegEx=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES  %@",emailRegEx];
    return [emailTest evaluateWithObject:email];
}

- (NSString *)stringURLForFunction:(NSString *)function {
    
    return [NSString stringWithFormat:@"%@%@", _EX_WSBaseURL, function];
}

#pragma mark - Loading View Methods

- (UIView *)showLoadingViewWithText:(NSString *)text {
    
    CGRect screen = self.screenRect;
    
    UIView *viewLoading = [[UIView alloc] initWithFrame:screen];
    [viewLoading setBackgroundColor:[UIColor clearColor]];
    
    UIView *viewActivity = [[UIView alloc] initWithFrame:CGRectMake(screen.size.width / 2 - 30, screen.size.height / 2 - 30, 60, 60)];
    [viewActivity setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.8]];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [spinner setHidesWhenStopped:YES];
    [spinner setCenter:CGPointMake(viewActivity.frame.size.width / 2, viewActivity.frame.size.height / 2)];
    [spinner startAnimating];
    
    [viewActivity addSubview:spinner];
    
    [viewLoading addSubview:viewActivity];
    
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    [lastWindow addSubview:viewLoading];
    
    return viewLoading;
}

- (void)hideLoadingView:(UIView *)viewLoading {
    
    [viewLoading.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSLog(@"Array count : %@", viewLoading.subviews);
    [viewLoading removeFromSuperview];
}

- (void)unexpectedErrorWithLoadingView:(UIView *)viewLoading {
    
    [self hideLoadingView:viewLoading];
    [[[UIAlertView alloc] initWithTitle:@"Error"
                                message:@"Well this is unexpected, please try later."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
}

- (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message {
    
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
}

- (void)setImageForLeftView:(NSString *)imageName forTextField:(UITextField *)textField {
    
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    
    UIView *viewLeftUsrnme = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 38)];
    [viewLeftUsrnme setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *imgVwUser = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 18, 28)];
    [imgVwUser setImage:[UIImage imageNamed:imageName]];
    [imgVwUser setContentMode:UIViewContentModeScaleAspectFit];
    [viewLeftUsrnme addSubview:imgVwUser];
    [textField setLeftView:viewLeftUsrnme];
}

@end
