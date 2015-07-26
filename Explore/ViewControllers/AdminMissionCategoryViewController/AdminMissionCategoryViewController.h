//
//  AdminMissionCategoryViewController.h
//  Explore
//
//  Created by Varun on 26/07/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ChoiceCategory = 1,
    ChoiceMission,
} AdminChoice;

@interface AdminMissionCategoryViewController : UIViewController

@property (assign, nonatomic) AdminChoice adminChoiceType;

@end
