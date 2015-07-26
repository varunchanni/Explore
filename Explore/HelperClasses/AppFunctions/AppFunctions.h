//
//  AppFunctions.h
//  Explore
//
//  Created by Varun on 10/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppFunctions : NSObject

//  Shared Instance

+ (id)sharedFunctions;

//  Other Methods

- (CGRect)screenRect;
- (BOOL)validateEmail:(NSString *)email;
- (NSString *)stringURLForFunction:(NSString *)function;
- (UIView *)showLoadingViewWithText:(NSString *)text;
- (void)hideLoadingView:(UIView *)viewLoading;
- (void)unexpectedErrorWithLoadingView:(UIView *)viewLoading;
- (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message;
- (void)setImageForLeftView:(NSString *)imageName forTextField:(UITextField *)textField;

@end
