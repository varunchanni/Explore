//
//  QuestionModel.h
//  Explore
//
//  Created by Varun on 1/08/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionModel : NSObject

@property (strong, nonatomic) NSString *quesID;
@property (strong, nonatomic) NSString *quesText;
@property (strong, nonatomic) NSString *quesAnswer;
@property (strong, nonatomic) NSString *quesPoints;
@property (strong, nonatomic) NSMutableArray *quesArrMissions;

@end
