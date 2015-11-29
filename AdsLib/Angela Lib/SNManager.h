//
//  SNManager.h
//  Alien Tower
//
//  Created by Asad Khan on 05/02/2013.
//
//

#import <Foundation/Foundation.h>

#import <Availability.h>

/*
 #if !__has_feature(objc_arc)
 #error This class requires automatic reference counting
 #endif
 */
#define IS_IOS7_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#ifdef DEBUG
#define DebugLog(f, ...) NSLog(f, ## __VA_ARGS__)
#else
#define DebugLog(f, ...)
#endif


#define kPlayHavenAdTimeOutThresholdValue 6.0
#define kAppLovinTimeOutThresholdValue 6.0
#define kChartBoostTimeOutThresholdValue 6.0


#define kLeadBoltLinkAdID @"866069241"


#ifdef FreeApp

#define ChartBoostAppID @"54d2d17cc909a65f6da4039e" //
#define ChartBoostAppSignature @"60604cf5f7f8fd47c24a8e66268cad4c256d90c4" //

#define kAppLovinID @"72p0QCCeF4dcq9v5at2nHmiOJVDd9UfGWSGyeTbvXDVLNORzGTlTERxXx8A4dqL9Gc5w4gpcvJzGhPDztyV5NR"

#define kPlayHavenAppToken @"969cc2b5776249ebb2cf92492e6f0ee5"
#define kPlayHavenSecret @"2dc9e2b914bb46d9b7d3553bfe1f4365"
#define kPlayHavenPlacement @"main_menu"

#ifdef IS_IOS7_AND_UP
#define kRateURL @"itms-apps://itunes.apple.com/app/id965693892"
#else
#define kRateURL @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=854412346"
#endif

#endif

#ifdef PaidApp

#define ChartBoostAppID @"51540b9517ba474233000019" //
#define ChartBoostAppSignature @"9953afb75246c3a03b10b526a0ea05dded6572cd" //

#define kPlayHavenAppToken @"969cc2b5776249ebb2cf92492e6f0ee5"
#define kPlayHavenSecret @"2dc9e2b914bb46d9b7d3553bfe1f4365"
#define kPlayHavenPlacement @"main_menu"

#define kTapJoyAppID @""
#define kTapJoySecretKey @""


#ifdef IS_IOS7_AND_UP
    #define kRateURL @"itms-apps://itunes.apple.com/app/id965693892"
#else
    #define kRateURL @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=883981160"
#endif

#endif



typedef NS_ENUM(NSUInteger, adPriorityLevel){
    kPriorityLOWEST = 10,
    kPriorityNORMAL,
    kPriorityHIGHEST
};

typedef NS_ENUM(NSUInteger, ConnectionStatus) {
    
    kNotAvailable,
    kWANAvailable,
    kWifiAvailable
    
};

/*
 These are the default values before changing them do consult Angela
 */


#define kChartBoostFullScreeAdPriority kPriorityNORMAL
#define kChartBoostMoreAppsAd kPriorityHIGHEST


#define kPlayHavenFullScreenAdPriority kPriorityNORMAL

#define kAppLovinBannerAdPriority kPriorityNORMAL
#define kAppLovinFullScreenAdPriority kPriorityHIGHEST

#define kNumberOfAdNetworks 3





@interface SNManager : NSObject



@end
