//
//  UserModel.h
//  Explore
//
//  Created by Varun on 1/08/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userMobile;
@property (strong, nonatomic) NSString *userAddress;
@property (strong, nonatomic) NSString *userImageUrl;

@end
