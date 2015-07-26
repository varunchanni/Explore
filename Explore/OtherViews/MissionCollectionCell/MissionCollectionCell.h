//
//  MissionCollectionCell.h
//  Explore
//
//  Created by Varun on 2/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  MissionCellDelegate <NSObject>

- (void)infoButtonTappedForMission;

@end

@interface MissionCollectionCell : UICollectionViewCell

@property (assign, nonatomic) id<MissionCellDelegate> delegate;

- (void)setSelectionGray:(BOOL)selection;
- (void)setCollectionCellContentToObject:(NSDictionary *)objMission;

@end
