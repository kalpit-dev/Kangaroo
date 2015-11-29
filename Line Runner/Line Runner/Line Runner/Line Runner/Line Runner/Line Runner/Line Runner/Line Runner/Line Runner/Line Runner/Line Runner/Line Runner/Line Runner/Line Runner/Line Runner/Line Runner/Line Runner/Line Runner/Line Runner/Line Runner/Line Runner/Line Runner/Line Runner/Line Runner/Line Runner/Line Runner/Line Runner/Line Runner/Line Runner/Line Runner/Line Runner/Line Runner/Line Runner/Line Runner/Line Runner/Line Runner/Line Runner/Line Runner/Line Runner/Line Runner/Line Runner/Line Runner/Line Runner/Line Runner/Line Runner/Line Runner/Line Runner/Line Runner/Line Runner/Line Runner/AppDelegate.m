//
//  AppDelegate.m
//  Line Runner
//
//  Created by Yang yang on 1/28/12.
//  Copyright physicsgametop 2012. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameConfig.h"
#import "HelloWorldLayer.h"
#import "RootViewController.h"
#import "Setting.h"
#import "SNAdsManager.h"
#import "LocalNotificationManager.h"
#import "AppTracker.h"

#include <net/if.h>
#include <ifaddrs.h>
#include <arpa/inet.h>


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



@implementation AppDelegate
int tapcount;
@synthesize window;
@synthesize m_ctrlThinking;
@synthesize indicatorView;
@synthesize intCounterForOptionAd,intCounterForGameOverAd;
/*

#define FB_APP_ID @"305910782791923"
//#define FB_API_KEY @"3269fff9ef3b6fc13255e670ebb44c4d"
#define FB_APP_SECRET @"309d7651d6fb8fb58894ec4cf53d9fd1"
*/
+(AppDelegate*) sharedDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

//	CC_ENABLE_DEFAULT_GL_STATES();
//	CCDirector *director = [CCDirector sharedDirector];
//	CGSize size = [director winSize];
//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
//	sprite.position = ccp(size.width/2, size.height/2);
//	sprite.rotation = -90;
//	[sprite visit];
//	[[director openGLView] swapBuffers];
//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}
- (void) applicationDidFinishLaunching:(UIApplication*)application
{
    
    intCounterForGameOverAd = intCounterForOptionAd = 1;
    
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
#ifdef FreeApp
    lockads = [[NSUserDefaults standardUserDefaults] boolForKey:@"lockads"];
#else
    lockads = TRUE;
#endif
  //  [SNAdsManager sharedManager].delegate=self;
  //  [[SNAdsManager sharedManager] giveMeLinkAd];
  //  [[SNAdsManager sharedManager] giveMeBannerAd];
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
    [glView setMultipleTouchEnabled:YES];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
    
    if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {
        [director setDeviceOrientation:kCCDeviceOrientationPortrait];
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")) {
        [director setDeviceOrientation:kCCDeviceOrientationPortrait];
    }
    
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:NO];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	//[window addSubview: viewController.view];
    window.rootViewController = viewController;
    if (lockads==FALSE) {
#ifdef FreeApp
      //  [[SNAdsManager sharedManager] giveMeBootUpAd];
#endif
    }
#ifdef PaidApp
 //   [[SNAdsManager sharedManager] giveMePaidFullScreenAd];
#endif
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

    chracter=1;
    // init gameData;
	if( !game_initialize() ){
		NSLog(@"App Init Fail !/////////////");
		exit(0);
	}

    UIImage *alphaImage = [UIImage imageNamed:@"alphaBlack.png"];
    indicatorView = [[UIImageView alloc] initWithImage:alphaImage];
    indicatorView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //    indicatorView.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
    
    [alphaImage release];
    [indicatorView setHidden:YES];
    
    [viewController.view addSubview:indicatorView];
    
    m_ctrlThinking = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [m_ctrlThinking setFrame:CGRectMake(SCREEN_WIDTH / 2 - 110 / 2 * kXForIPhone, SCREEN_HEIGHT / 2 - 110 / 2 * kYForIPhone, 110 * kXForIPhone, 110 * kYForIPhone)];
    
    [indicatorView addSubview:m_ctrlThinking];

    	// Removes the startup flicker
	[self removeStartupFlicker];
	
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene: [HelloWorldLayer scene]];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"gameOverCounter"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:1] forKey:@"gameOverCounter"];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    //change to 'return UIInterfaceOrientationIsPortrait(interfaceOrientation);' for portrait
}
- (BOOL) shouldAutorotate {
    
    BOOL shouldRotate = NO;
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    shouldRotate = (orientation == UIInterfaceOrientationMaskLandscape);
    
    return shouldRotate;
}


-(void) scheduleAlarm {
    LocalNotificationManager *localNotification = [[LocalNotificationManager alloc] initWithMessage:@"Run Fast to Complete the Challenges!"];
    // [localNotification testNotificationsSecondsWithSoundFileName:nil andMessage:@"Test Message"];
    [localNotification release];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notif {
    // Handle the notificaton when the app is running
    NSLog(@"Recieved Notification %@",notif);
    
	application.applicationIconBadgeNumber = 0;
}/*
- (void)linkAdDidFailToLoad {
    linkflag=TRUE;
}
- (void)bannerAdDidLoad{
    linkflag=TRUE;
}
- (void)bannerAdDidFailToLoad{
    linkflag=TRUE;
}*/
- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
    [self scheduleAlarm];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
    if (lockads==FALSE) {
    [[SNAdsManager sharedManager] giveMeWillEnterForegroundAd];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
	[super dealloc];
}

+(void)showingAdd
{
    UIStoryboard *storyBoardForAdView = [UIStoryboard storyboardWithName:@"AddViewStoryboard" bundle:[NSBundle mainBundle]];
    
    UIViewController *viewControllerForAd = [storyBoardForAdView instantiateViewControllerWithIdentifier:@"AdViewController"];
    
    [[[CCDirector sharedDirector] openGLView].window.rootViewController presentViewController:viewControllerForAd animated:YES completion:nil];
    
    
    
}

-(void)trackingFreeGameClicks
{
   // [self getSubNetMaskAndIp];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://cpapower.net/tracking/kshtracking.php?ip=%@",address]] ;
    
    CGRect screen = [UIScreen mainScreen].bounds;
    UIWebView *webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(screen.size.width+100, screen.size.height/2, 10, 10)];
    [webView1 loadRequest:[NSURLRequest requestWithURL:url]];
    webView1.tag = 1;
    webView1.hidden=TRUE;
    webView1.delegate = self;
    [window addSubview:webView1];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
//    [webView removeFromSuperview];
//    webView = nil;
    CGRect screen = [UIScreen mainScreen].bounds;
    if (webView.tag == 1)
    {
        NSURL *url2 =[NSURL URLWithString:[NSString stringWithFormat:@"http://cpapower.net/tracking/kshtrackingincent.php?ip=%@",address]] ;
        UIWebView *webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(screen.size.width+100, screen.size.height/2, 10, 10)];
        webView2.hidden=TRUE;
        webView2.delegate = self;
        webView2.tag = 2;
        [webView2 loadRequest:[NSURLRequest requestWithURL:url2]];
        [window addSubview:webView2];

    }
}


-(void) getSubNetMaskAndIp{
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    netmask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];
                    NSLog(@"%@",address);
                    
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
}


@end
