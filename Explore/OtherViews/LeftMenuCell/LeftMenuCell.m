//
//  LeftMenuCell.m
//  Explore
//
//  Created by Varun on 30/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "LeftMenuCell.h"

@interface LeftMenuCell () {
    
    __weak IBOutlet UILabel *lblMenuText;
    __weak IBOutlet UIImageView *imgMenuItem;
}

@end

@implementation LeftMenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIEdgeInsets)layoutMargins {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (BOOL)preservesSuperviewLayoutMargins {
    return NO;
}

- (void)setColorForLabel:(UIColor *)color {
    [lblMenuText setTextColor:color ? color : [UIColor lightGrayColor]];
}

- (void)setMenuItemWithDict:(NSDictionary *)dictMenuItem {
    
    [lblMenuText setText:[dictMenuItem objectForKey:@"menuItem"]];
    [imgMenuItem setImage:[UIImage imageNamed:[dictMenuItem objectForKey:@"menuImage"]]];
}

@end
