//
//  Constants.m
//  Explore
//
//  Created by Varun on 10/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "Constants.h"

@implementation Constants

#pragma mark - UserDefault Keys

NSString *const _EX_UDKeyLogin          = @"UserLoggedIn";
NSString *const _EX_UDKeyUType          = @"ULoggedInType";

#pragma mark - Storyboard Constants

NSString *const _EX_IDStrbrdAdmin           = @"Admin";
NSString *const _EX_IDMainStrbrd            = @"Main";

NSString *const _EX_IDNavAdminStrbrdID      = @"AdminNavigationController";

NSString *const _EX_IDMainNavStrbrd         = @"MainNavStrbrdID";
NSString *const _EX_IDCityMissionStrbrd     = @"CityMissionStrbrdID";
NSString *const _EX_IDFeedViewStrbrdID      = @"FeedViewStrbrdID";
NSString *const _EX_IDMissionsViewStrbrd    = @"MissionsViewStrbrdID";
NSString *const _EX_IDLeftMenuStrbrd        = @"LeftMenuStrbrdID";
NSString *const _EX_IDRightMenuStrbrd       = @"RightMenuStrbrdID";
NSString *const _EX_IDLoginStrbrd           = @"LoginNavStrbrdID";
NSString *const _EX_IDMssonStrbrdID         = @"MissionStrbrdID";
NSString *const _EX_IDAbtMssonStrbrdID      = @"AboutMissionStrbrdID";
NSString *const _EX_IDMssonDoneStrbrdID     = @"MissionDoneStrbrdID";
NSString *const _EX_IDPrfleNavStrbrdID      = @"ProfileNavStrbrdID";
NSString *const _EX_IDProfileStrbrdID       = @"ProfileStrbrdID";
NSString *const _EX_IDAboutUsNavStrbrdID    = @"AboutUsNavStrbrdID";
NSString *const _EX_IDCupnsNavStrbrdID      = @"CouponsNavStrbrdID";

NSString *const _EX_IDAdminCatMission       = @"AdminMissionCategoryStrbrdID";

#pragma mark - Webservice Constants

NSString *const _EX_WSBaseURL           = @"http://easyexplore.net/commonservices/";

NSString *const _EX_WSLogin             = @"login";
NSString *const _EX_WSRegister          = @"registration";
NSString *const _EX_WSResetPass         = @"";

#pragma mark - Response Keys

NSString *const _EX_RSKeyError          = @"error_code";
NSString *const _EX_RSKeyMessage        = @"message";

@end
