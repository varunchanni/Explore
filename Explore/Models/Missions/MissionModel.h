//
//  MissionModel.h
//  Explore
//
//  Created by Varun on 26/07/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MissionModel : NSObject

@property (strong, nonatomic) NSString *missionID;
@property (strong, nonatomic) NSString *missionName;
@property (strong, nonatomic) NSString *missionCategory;
@property (strong, nonatomic) NSString *missionDescription;
@property (strong, nonatomic) NSString *missionImageUrl;

@end
