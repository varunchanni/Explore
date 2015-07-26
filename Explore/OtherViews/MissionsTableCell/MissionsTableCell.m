//
//  MissionsTableCell.m
//  Explore
//
//  Created by Varun on 6/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "MissionsTableCell.h"
#import "MissionCollectionCell.h"

static NSString *REUSEMissionCell = @"ReuseMissionCell";

@interface MissionsTableCell () <UICollectionViewDelegate, UICollectionViewDataSource, MissionCellDelegate> {
    
    __weak IBOutlet UILabel *lblMissionHeading;
    __weak IBOutlet UICollectionView *collectionMissions;
}

@end

@implementation MissionsTableCell

- (void)awakeFromNib {
    // Initialization code
    
    UINib *nibNameCollCell = [UINib nibWithNibName:@"MissionCollectionCell" bundle:nil];
    [collectionMissions registerNib:nibNameCollCell forCellWithReuseIdentifier:REUSEMissionCell];
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(130, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [collectionMissions setCollectionViewLayout:flowLayout];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMissionTableCellContentToDict:(NSDictionary *)dictMission {
    
}

#pragma mark - UICollectionView Delegate & DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    NSMutableArray *arrSection = [arrSpotsData objectAtIndex:section];
    //    return [arrSpotsData count];
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MissionCollectionCell *cell = (MissionCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:REUSEMissionCell forIndexPath:indexPath];
    //    [cell fillCellWithCellText:objSpot];
    [cell setDelegate:self];
    return cell;
}

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    MissionCollectionCell *cell = (MissionCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    [cell setSelectionGray:YES];
//    return cell;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MissionCollectionCell *cell = (MissionCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelectionGray:YES];
    
    if ([self.delegate respondsToSelector:@selector(didSelectTheCollectionCellAtIndex:)])
        [self.delegate didSelectTheCollectionCellAtIndex:indexPath];
    //    DLog(@"Index Row : %ld", indexPath.row);
}

#pragma mark - Mission Cell Delegate

- (void)infoButtonTappedForMission {
    if ([self.delegate respondsToSelector:@selector(infoButtonTappedOnMissionCell)])
        [self.delegate infoButtonTappedOnMissionCell];
}

@end
