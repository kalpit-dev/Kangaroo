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
#import "LocalNotificationManager.h"
#import "AdViewController.h"
#import "DemoViewController.h"
#include <net/if.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "AdModel.h"
#import <UIKit/UIKit.h>



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
@synthesize intCounterForOptionAd,intCounterForGameOverAd,isKeyBoardActive;
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
    
    
    AdModel *Ad = [[AdModel alloc] initAdProfile];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstTime"])
    {
        NSLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:@"firstTime"]);
        [Ad creatingUser];
    }
   // [Ad gettingScore];
    [Ad gettingAdProfileDetails];
#warning delete it after testing
    [self showAlertFortesting];
    intCounterForGameOverAd = intCounterForOptionAd = 1;
    
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
#ifdef FreeApp
    lockads = [[NSUserDefaults standardUserDefaults] boolForKey:@"lockads"];
#else
    lockads = TRUE;
#endif



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
        
#endif
    }
#ifdef PaidApp
    
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
    UIView *viewWebAd = [self.window.rootViewController.view viewWithTag:888];
    if (viewWebAd!=nil)
    {
        [viewWebAd removeFromSuperview];
    }
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
    if (lockads==FALSE) {

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

-(void)showAlertFortesting
{
    AdModel *ad = [[AdModel alloc] initAdProfile];
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:nil message:[ad getUniqueDeviceIdentifierAsString] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alt show];
}

-(void)showingAddFromGame:(BOOL)fromGame
{
    
    UIStoryboard *storyBoardForAdView = [UIStoryboard storyboardWithName:@"AddViewStoryboard" bundle:[NSBundle mainBundle]];
    AdViewController *viewControllerForAd = [storyBoardForAdView instantiateViewControllerWithIdentifier:@"AdViewController"];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    int counter = [[[NSUserDefaults standardUserDefaults] objectForKey:@"gameOverCounter"] intValue];
    NSString *str = @"";
    NSString *strHeader = @"";
    AdModel *ad = [[AdModel alloc] initAdProfile];

    if (counter == 3 || counter % 7 == 0 )  // is equal to zero
    {
        counter = [[[NSUserDefaults standardUserDefaults] objectForKey:@"gameOverCounter"] intValue];
    
        if (counter == 3)
        {
            str = @"We want to say thank you by offering you the chance to earn rewards for playing our game. \nEvery time you complete a level you will be shown our \"Superhero Rewards\" offer wall. \nComplete any offer from our wall to earn \"kangaroo hops\" that you will be able to exchange for Amazon, iTunes, Google Play and Skype gift cards!";
            if (ad.adObject.strPlayScore != nil) {
                    strHeader = [NSString stringWithFormat:@"Congratulations! You have completed Level 1! Your Score is %@ hops",ad.adObject.strPlayScore];
            }
            else {
                strHeader = [NSString stringWithFormat:@"Congratulations! You have completed Level 1!"];
            }
            
        }
        else
        {
            str = @"Complete offers to earn \"kangaroo hops\" and you will soon be able to request a gift card of your choice!";
            if (ad.adObject.strPlayScore != nil) {
                strHeader = [NSString stringWithFormat:@"Congratulations! You have completed Level %d! Your Score is %@ hops",(counter/7)+1,ad.adObject.strPlayScore];
            }
            else {
                    strHeader = [NSString stringWithFormat:@"Congratulations! You have completed Level %d!",(counter/7)+1];
            }
            
        }
    
    if (counter/7+1 > 100)
    {
        str = @"Complete offers to earn \"kangaroo hops\". Keep earning more \"hops\" with every offer you complete and request a cash prize (Minimum 5,000 hops for US$5 Cash Prize).";
        strHeader = @"Thank you for being such a \"Super Hero\"! Let us reward your loyalty!";
    }
    
    viewControllerForAd.strInfo = str;
    viewControllerForAd.strHeader = strHeader;

  //  [app.window.rootViewController presentViewController:viewDemo animated:YES completion:nil];
    [app.window.rootViewController.view addSubview:viewControllerForAd.view];
    [viewControllerForAd.btnClose addTarget:self action:@selector(btnClose:) forControlEvents:UIControlEventTouchUpInside];
    [viewControllerForAd.btnRedeem addTarget:self action:@selector(AddingView:) forControlEvents:UIControlEventTouchUpInside];
    viewControllerForAd.btnRedeem.layer.cornerRadius = 2.0;
    viewControllerForAd.btnRedeem.layer.masksToBounds = YES;
        
    }
    else if(!fromGame)
    {
        str = @"Complete offers to earn \"kangaroo hops\". Keep earning more \"hops\" with every offer you complete and request a cash prize (Minimum 5,000 hops for US$5 Cash Prize).";
        strHeader = @"Thank you for being such a \"Super Hero\"! Let us reward your loyalty!";
        viewControllerForAd.strInfo = str;
        viewControllerForAd.strHeader = strHeader;
        
        //  [app.window.rootViewController presentViewController:viewDemo animated:YES completion:nil];
        [app.window.rootViewController.view addSubview:viewControllerForAd.view];
        [viewControllerForAd.btnClose addTarget:self action:@selector(btnClose:) forControlEvents:UIControlEventTouchUpInside];
        [viewControllerForAd.btnRedeem addTarget:self action:@selector(AddingView:) forControlEvents:UIControlEventTouchUpInside];
        viewControllerForAd.btnRedeem.layer.cornerRadius = 2.0;
        viewControllerForAd.btnRedeem.layer.masksToBounds = YES;

    }
   // [app.window.rootViewController presentViewController:viewControllerForAd animated:YES completion:nil];
//    counter++;
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:counter] forKey:@"gameOverCounter"];
    
//    [[[CCDirector sharedDirector] openGLView].window.rootViewController presentViewController:viewControllerForAd animated:YES completion:nil];
    
}

-(void)addClicked:(UIButton *)sender
{
    NSLog(@"%@",self.arrayData);
    UIButton *btn = sender;
    NSLog(@"%ld",(long)btn.tag);
    int index = btn.tag;
    UIStoryboard *storyBoardForAdView = [UIStoryboard storyboardWithName:@"AddViewStoryboard" bundle:[NSBundle mainBundle]];
    DemoViewController *demoView = [storyBoardForAdView instantiateViewControllerWithIdentifier:@"DemoViewController"];
    demoView.strURLToLoad = [[self.arrayData objectAtIndex:index] objectForKey:@"click_url"];
    NSString *strURL = [[self.arrayData objectAtIndex:index] objectForKey:@"click_url"];
    UIView *viewAd  = [[UIView alloc] initWithFrame:self.window.rootViewController.view.frame];
    viewAd.tag = 888;
    UIWebView *webViewAd = [[UIWebView alloc] initWithFrame:viewAd.frame];
    [webViewAd loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strURL]]];
    [viewAd addSubview:webViewAd];
    
    UIButton *btnWebView = [UIButton buttonWithType:UIButtonTypeCustom];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        btnWebView.frame = CGRectMake(demoView.view.frame.size.width-55, 20, 50, 50);
    }
    else
    {
        btnWebView.frame = CGRectMake(demoView.view.frame.size.width-45, 10, 40, 40);
    }
    btnWebView.backgroundColor = [UIColor clearColor];
    [btnWebView setBackgroundImage:[UIImage imageNamed:@"close_red.png"] forState:UIControlStateNormal];
    btnWebView.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [viewAd addSubview:btnWebView];
    [btnWebView addTarget:self action:@selector(btnWebClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.window.rootViewController.view addSubview:viewAd];
    
}

-(void)btnClose:(UIButton *)sender
{
    UIButton *btn = sender;
    [btn.superview removeFromSuperview];
    AdModel *ad = [[AdModel alloc] init];
    [ad gettingAdProfileDetails];

}

-(void)btnWebClose:(UIButton *)sender
{
    UIButton *btn = sender;
    [btn.superview removeFromSuperview];
    AdModel *ad = [[AdModel alloc] init];
    [ad gettingAdProfileDetails];
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

-(void)AddingView:(UIButton *)sender
{
    [self creatingView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
    isKeyBoardActive = TRUE;
}

- (void)keyboardDidHide: (NSNotification *) notif{
    // Do something here
    isKeyBoardActive = FALSE;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {        UIView *viewSuper = [self.window.rootViewController.view viewWithTag:777];
        if (viewSuper && viewSuper.frame.origin.y<0)
        {
            [viewSuper setFrame:CGRectMake(viewSuper.frame.origin.x, 0, viewSuper.frame.size.width, viewSuper.frame.size.height)];
        }
        
    }
}

-(void)done:(UIButton *)sender
{
    UIButton *btn = sender;
    if ([btn.titleLabel.text  isEqual: @"Close"])
    {
        [btn.superview removeFromSuperview];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    }
    else
    {
        if ([self gettingData])
        {
            [btn.superview removeFromSuperview];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
        }
        else
        {
            
        }
        
    }
    
}

-(BOOL)gettingData
{
    UIView *view = [self.window.rootViewController.view viewWithTag:777];
    UITextField *txtName = (UITextField *)[view viewWithTag:1];
    UITextField *txtAddress = (UITextField *)[view viewWithTag:2];
    UITextField *txtContact = (UITextField *)[view viewWithTag:3];
    UITextField *txtEmail = (UITextField *)[view viewWithTag:4];
    UITextField *txtCountry = (UITextField *)[view viewWithTag:5];
    UITextField *txtAmount = (UITextField *)[view viewWithTag:6];
    AdModel *ad = [[AdModel alloc] initAdProfile];
    
    if ([self validateEmailWithString:txtEmail.text])
    {
        NSString *strGiftCardType = nil;
        if ([txtCountry.text isEqualToString:@"United States Of America"])
        {
            strGiftCardType = @"0";
        }
        else
        {
            strGiftCardType = @"1";
        }
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:txtName.text,@"player_name",txtAddress.text,@"address",txtContact.text,@"contact_number",txtEmail.text,@"email_id",strGiftCardType,@"gift_card_type",@"1",@"redeem_mode",txtAmount.text,@"redeem_amount",[ad getUniqueDeviceIdentifierAsString],@"player_id", nil];
        NSLog(@"%@",dict);
        
        [ad redeemPoints:dict];
        return TRUE;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Validation" message:@"Please enter correct email id" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return FALSE;
    }
        
    
    
    
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark text field delegates
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 5)
    {
        [textField resignFirstResponder];
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Select" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"United States Of America",@"Other", nil];
        action.tag = 1;
        [action showInView:textField.superview];
    }
//    else if (textField.tag == 6)
//    {
//        [textField resignFirstResponder];
//        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Select Amount" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"$5",@"$10",@"$15", nil];
//        action.tag = 2;
//        [action showInView:self.window.rootViewController.view];
//    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {        UIView *viewSuper = textField.superview;
            if (textField.tag == 6)
            {
                [viewSuper setFrame:CGRectMake(viewSuper.frame.origin.x, viewSuper.frame.origin.y-60, viewSuper.frame.size.width, viewSuper.frame.size.height)];
            }
            else{
                    [viewSuper setFrame:CGRectMake(viewSuper.frame.origin.x, viewSuper.frame.origin.y-20, viewSuper.frame.size.width, viewSuper.frame.size.height)];
            }
            
        }
    }
    
}

#pragma mark actionsheet delegates
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIView *viewRedeem = [self.window.rootViewController.view viewWithTag:777];
    if (actionSheet.tag == 1)
    {
        UITextField *txtCountry = (UITextField *)[viewRedeem viewWithTag:5];
        switch (buttonIndex) {
            case 0:
                [txtCountry setText:@"United States Of America"] ;
                break;
            case 1:
                [txtCountry setText:@"Other"] ;
                break;
                
            default:
                break;
        }
    }
    else if (actionSheet.tag == 2)
    {
        UITextField *txtamount = (UITextField *)[viewRedeem viewWithTag:6];
        switch (buttonIndex) {
            case 0:
                [txtamount setText:@"$5"] ;
                break;
            case 1:
                [txtamount setText:@"$10"] ;
                break;
            case 2:
                [txtamount setText:@"$15"] ;
                break;
            default:
                break;
        }

    }
    
}

- (void)creatingView
{
    UIView *viewMain = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.window.rootViewController.view.frame.size.width, self.window.rootViewController.view.frame.size.height)];
    viewMain.tag = 777;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:viewMain.frame];
    imgView.image = [UIImage imageNamed:@"back_ipad.png"];
    [viewMain addSubview:imgView];
    viewMain.backgroundColor = [UIColor whiteColor];
    UITextField *txtName = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    txtName.placeholder = @"Name";
    txtName.tag=1;
    UITextField *txtAddress = [[UITextField alloc] initWithFrame:CGRectMake(10, 45, 300, 30)];
    txtAddress.placeholder = @"Address";
    txtAddress.tag = 2;
    //contact_number,email_id,country,gift_card_type,redeem_amount
    UITextField *txtContact = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 300, 30)];
    txtContact.placeholder = @"Contact Number";
    txtContact.keyboardType = UIKeyboardTypeNumberPad;
    txtContact.tag = 3;
    UITextField *txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(10, 115, 300, 30)];
    txtEmail.placeholder = @"Email ID";
    txtEmail.tag = 4;
    txtEmail.delegate = self;
    
    UITextField *txtCountry = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, 300, 30)];
    txtCountry.placeholder = @"Country";
    txtCountry.tag = 5;
    txtCountry.delegate = self;
    
    UITextField *txtRedeemAmount = [[UITextField alloc] initWithFrame:CGRectMake(10, 185, 300, 30)];
    txtRedeemAmount.placeholder = @"Redeem amount";
    txtRedeemAmount.tag = 6;
    txtRedeemAmount.delegate = self;
    txtRedeemAmount.keyboardType = UIKeyboardTypeNumberPad;
    
    [viewMain addSubview:txtName];
    [viewMain addSubview:txtAddress];
    [viewMain addSubview:txtContact];
    [viewMain addSubview:txtEmail];
    [viewMain addSubview:txtCountry];
    [viewMain addSubview:txtRedeemAmount];
    
    txtName.backgroundColor = [UIColor whiteColor];
    txtAddress.backgroundColor = [UIColor whiteColor];
    txtCountry.backgroundColor = [UIColor whiteColor];
    txtContact.backgroundColor = [UIColor whiteColor];
    txtEmail.backgroundColor = [UIColor whiteColor];
    txtRedeemAmount.backgroundColor = [UIColor whiteColor];
    
    txtName.center = CGPointMake(viewMain.center.x, txtName.center.y);
    txtAddress.center = CGPointMake(viewMain.center.x, txtAddress.center.y);
    txtCountry.center = CGPointMake(viewMain.center.x, txtCountry.center.y);
    txtContact.center = CGPointMake(viewMain.center.x, txtContact.center.y);
    txtEmail.center = CGPointMake(viewMain.center.x, txtEmail.center.y);
    txtRedeemAmount.center = CGPointMake(viewMain.center.x, txtRedeemAmount.center.y);

    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    btnDone.titleLabel.textColor = [UIColor whiteColor];
    [btnDone addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    btnDone.frame = CGRectMake(txtName.frame.origin.x, 245, 100, 40);
    btnDone.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:150.0/255.0 blue:210.0/255.0 alpha:1.0];
    [viewMain addSubview:btnDone];
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose setTitle:@"Close" forState:UIControlStateNormal];
    btnClose.titleLabel.textColor = [UIColor whiteColor];
    [btnClose addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    btnClose.frame = CGRectMake(txtName.frame.size.width+txtName.frame.origin.x - 100, 245, 100, 40);
    btnClose.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:150.0/255.0 blue:210.0/255.0 alpha:1.0];
    [viewMain addSubview:btnClose];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        txtName.frame = CGRectMake(txtName.frame.origin.x, 40, 400, 60);
        txtName.center = CGPointMake(viewMain.center.x, txtName.center.y);
        
        txtAddress.frame = CGRectMake(txtAddress.frame.origin.x, 110, 400, 60);
        txtAddress.center = CGPointMake(viewMain.center.x, txtAddress.center.y);
        
        txtContact.frame = CGRectMake(txtContact.frame.origin.x, 180, 400, 60);
        txtContact.center = CGPointMake(viewMain.center.x, txtContact.center.y);
        
        txtEmail.frame = CGRectMake(txtEmail.frame.origin.x, 250, 400, 60);
        txtEmail.center = CGPointMake(viewMain.center.x, txtEmail.center.y);
        
        txtCountry.frame = CGRectMake(txtCountry.frame.origin.x, 320, 400, 60);
        txtCountry.center = CGPointMake(viewMain.center.x, txtCountry.center.y);
        
        txtRedeemAmount.frame = CGRectMake(txtRedeemAmount.frame.origin.x, 390, 400, 60);
        txtRedeemAmount.center = CGPointMake(viewMain.center.x, txtRedeemAmount.center.y);
        
        btnDone.frame = CGRectMake(txtName.frame.origin.x, 490, 150, 60);
        btnClose.frame = CGRectMake(txtName.frame.size.width+txtName.frame.origin.x - 150, 490, 150, 60);
    }
    
    [self.window.rootViewController.view addSubview:viewMain];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [viewMain addGestureRecognizer:gesture];
}

-(void)tapped:(UITapGestureRecognizer *)reconizer
{
    if (isKeyBoardActive)
    {
        [reconizer.view endEditing:YES];
    }
    else
    {
//        [reconizer.view removeFromSuperview];
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    }
    
}
@end
