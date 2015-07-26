//
//  MissionOptionCell.m
//  Explore
//
//  Created by Varun on 3/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "MissionOptionCell.h"

@interface MissionOptionCell () {
    
    __weak IBOutlet UILabel *lblOptionText;
    __weak IBOutlet UIImageView *imgViewOption;
}

@end

@implementation MissionOptionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellContentWithText:(NSString *)text andImage:(NSString *)imgName {
    [lblOptionText setText:text];
    [imgViewOption setImage:[UIImage imageNamed:imgName]];
}

@end
