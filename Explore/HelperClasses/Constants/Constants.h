//
//  Constants.h
//  Explore
//
//  Created by Varun on 10/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EXUserDefs [NSUserDefaults standardUserDefaults]
#define EXAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define EXAppFunctions [AppFunctions sharedFunctions]

@interface Constants : NSObject

//  Font Constants

FOUNDATION_EXPORT NSString *const _EX_Font;

//  User Default Constants

FOUNDATION_EXPORT NSString *const _EX_UDKeyLogin;
FOUNDATION_EXPORT NSString *const _EX_UDKeyUType;

//  Storyboard Constants

FOUNDATION_EXPORT NSString *const _EX_IDMainStrbrd;
FOUNDATION_EXPORT NSString *const _EX_IDMainNavStrbrd;
FOUNDATION_EXPORT NSString *const _EX_IDFeedViewStrbrdID;
FOUNDATION_EXPORT NSString *const _EX_IDMissionsViewStrbrd;
FOUNDATION_EXPORT NSString *const _EX_IDCityMissionStrbrd;
FOUNDATION_EXPORT NSString *const _EX_IDLeftMenuStrbrd;
FOUNDATION_EXPORT NSString *const _EX_IDRightMenuStrbrd;
FOUNDATION_EXPORT NSString *const _EX_IDLoginStrbrd;
FOUNDATION_EXPORT NSString *const _EX_IDMssonStrbrdID;
FOUNDATION_EXPORT NSString *const _EX_IDAbtMssonStrbrdID;
FOUNDATION_EXPORT NSString *const _EX_IDMssonDoneStrbrdID;
FOUNDATION_EXPORT NSString *const _EX_IDAboutUsNavStrbrdID;
FOUNDATION_EXPORT NSString *const _EX_IDPrfleNavStrbrdID;
FOUNDATION_EXPORT NSString *const _EX_IDCupnsNavStrbrdID;

FOUNDATION_EXPORT NSString *const _EX_IDAdminCatMission;

//  Webservice Constants

FOUNDATION_EXPORT NSString *const _EX_WSBaseURL;
FOUNDATION_EXPORT NSString *const _EX_WSLogin;
FOUNDATION_EXPORT NSString *const _EX_WSRegister;
FOUNDATION_EXPORT NSString *const _EX_WSResetPass;

//  Response Keys

FOUNDATION_EXPORT NSString *const _EX_RSKeyError;
FOUNDATION_EXPORT NSString *const _EX_RSKeyMessage;

@end
