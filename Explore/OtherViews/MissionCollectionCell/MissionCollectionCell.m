//
//  MissionCollectionCell.m
//  Explore
//
//  Created by Varun on 2/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "MissionCollectionCell.h"

@interface MissionCollectionCell () {
    
    __weak IBOutlet UIView *viewMain;
    __weak IBOutlet UIImageView *imgViewMission;
    __weak IBOutlet UILabel *lblMissionText;
    __weak IBOutlet UILabel *lblMissionDetailText;
    __weak IBOutlet UIButton *btnInfo;
}

@end

@implementation MissionCollectionCell

- (void)prepareForReuse {
    [viewMain setBackgroundColor:[UIColor whiteColor]];
}

- (void)awakeFromNib {
    // Initialization code

    [viewMain.layer setCornerRadius:2.f];
    [viewMain.layer setShadowOffset:CGSizeMake(0, 1)];
    [viewMain.layer setShadowColor:[UIColor darkGrayColor].CGColor];
    [viewMain.layer setShadowOpacity:0.25f];
    [viewMain.layer setShadowRadius:0.8f];
    
    [btnInfo.layer setCornerRadius:15];
}

- (void)setSelectionGray:(BOOL)selection {
    
}

- (void)setCollectionCellContentToObject:(NSDictionary *)objMission {
    
}

#pragma mark - IBAction Info Button

- (IBAction)buttonInfoMissionAction:(id)sender {

    if ([self.delegate respondsToSelector:@selector(infoButtonTappedForMission)])
        [self.delegate infoButtonTappedForMission];
}

@end
