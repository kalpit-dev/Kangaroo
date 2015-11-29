//
//  AppDelegate.h
//  Line Runner
//
//  Created by Yang yang on 1/28/12.
//  Copyright physicsgametop 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdViewController.h"


@class RootViewController;
BOOL lockads;
int chracter;
BOOL linkflag;
@interface AppDelegate : NSObject <UIApplicationDelegate,UIWebViewDelegate,UITextFieldDelegate,UIActionSheetDelegate> {
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
@property (nonatomic, retain) NSArray *arrayData;
@property (nonatomic) BOOL isKeyBoardActive;


+ (AppDelegate *)sharedDelegate;
-(void)showingAddFromGame:(BOOL)fromGame;
-(void)trackingFreeGameClicks;

@end
