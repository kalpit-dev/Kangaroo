//
//  AppDelegate.h
//  Line Runner
//
//  Created by Yang yang on 1/28/12.
//  Copyright physicsgametop 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNAdsManager.h"

@class RootViewController;
BOOL lockads;
int chracter;
BOOL linkflag;
@interface AppDelegate : NSObject <UIApplicationDelegate,SNAdsManagerDelegate,UIWebViewDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;

#pragma mark In app
    
    UIImageView* indicatorView;
    UIActivityIndicatorView*	m_ctrlThinking;
    
    int intCounterForOptionAd,intCounterForGameOverAd;    //managing the counter for showing ads only for odd numbers.
    
    int success;
    NSString *address;
    struct ifaddrs *interfaces;
    struct ifaddrs *temp_addr;
    NSString *netmask;



}

@property (nonatomic, retain) UIActivityIndicatorView*	m_ctrlThinking;
@property (nonatomic, retain) UIImageView *indicatorView;

@property (nonatomic, retain) UIWindow *window;

@property (nonatomic,readwrite) int intCounterForOptionAd,intCounterForGameOverAd;




+ (AppDelegate *)sharedDelegate;
+ (void)showingAdd;
-(void)trackingFreeGameClicks;

@end
