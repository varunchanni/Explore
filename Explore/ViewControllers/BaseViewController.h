//
//  BaseViewController.h
//  Explore
//
//  Created by Varun on 20/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//  Property will be used to pop to root view
//  controller from the derived class, when
//  back button will be tapped from the view
@property (assign, nonatomic) BOOL popToRootView;

- (void)enablePanMode:(BOOL)enable;

@end
