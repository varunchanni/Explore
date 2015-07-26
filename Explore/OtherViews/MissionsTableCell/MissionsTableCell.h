//
//  MissionsTableCell.h
//  Explore
//
//  Created by Varun on 6/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MissionTableDelegate <NSObject>

- (void)didSelectTheCollectionCellAtIndex:(NSIndexPath *)indexPath;
- (void)infoButtonTappedOnMissionCell;

@end

@interface MissionsTableCell : UITableViewCell

@property (assign, nonatomic) id<MissionTableDelegate> delegate;

@end
