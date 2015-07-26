//
//  FeedViewCell.m
//  Explore
//
//  Created by Varun on 10/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "FeedViewCell.h"

@interface FeedViewCell () {
    
    __weak IBOutlet UIView *viewButtons;
    __weak IBOutlet UIButton *btnLike;
    __weak IBOutlet UIButton *btnComment;
    
    __weak IBOutlet UIView *viewFeedInfo;
    __weak IBOutlet UIImageView *imgProfile;
    __weak IBOutlet UILabel *lblUsername;
    __weak IBOutlet UILabel *lblTimeElapsed;
    __weak IBOutlet UILabel *lblFeedText;
}

@end

@implementation FeedViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [imgProfile.layer setCornerRadius:4.f];
    
    [viewFeedInfo.layer setCornerRadius:3.f];
    [viewFeedInfo.layer setShadowColor:[UIColor darkGrayColor].CGColor];
    [viewFeedInfo.layer setShadowOffset:CGSizeMake(0, 1.5)];
    [viewFeedInfo.layer setShadowOpacity:0.25f];
    [viewFeedInfo.layer setShadowRadius:0.8f];
    
    [viewButtons.layer setCornerRadius:3.f];
    
    for (UIButton *button in viewButtons.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            [button.layer setBorderWidth:0.5f];
            [button.layer setBorderColor:[UIColor colorWithWhite:221/255.0f alpha:1.0f].CGColor];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillCellInfoForFeedInfo {
    
}

#pragma mark - IBAction Like

- (IBAction)buttonLikeTouched:(UIButton *)sender {
    [sender setSelected:!sender.selected];
}

#pragma mark - IBAction Comment

- (IBAction)buttonCommentTouched:(UIButton *)sender {
    [sender setSelected:!sender.selected];
}

@end
