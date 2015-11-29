//
//  Play.m
//  Line Runner!
//
//  Created by Yang yang on 1/29/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import "Play.h"
#import "Setting.h"
#import "Menu.h"
#import "GameLayer.h"
#import "AppDelegate.h"
#import "MKStoreManager.h"


#define POS_X_PREV_SOUND    (SCREEN_WIDTH / 3)
#define POS_Y_PREV_SOUND    (SCREEN_HEIGHT * 5 / 7)

#define POS_X_NEXT_SOUND    (SCREEN_WIDTH / 3 * 2)
#define POS_Y_NEXT_SMOKE    (SCREEN_HEIGHT * 4 / 7)

#define POS_BACK        (SCREEN_HEIGHT * 1 / 6)

@implementation Play

@synthesize parentMenu;
bool bluebike;
bool redbike;
bool yellowbike;

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        self.isTouchEnabled = YES;

        selectTrack = [CCSprite spriteWithFile:@"t_select.png"];
        selectTrack.anchorPoint = ccp(0.5, 1);
        selectTrack.scale = kXForIPhone;
        selectTrack.position = ccp(SCREEN_WIDTH / 2, 663 * kYForIPhone);
        [self addChild:selectTrack];
        
        btprevSound = [CCMenuItemImage itemFromNormalImage:@"bt_left01.png" selectedImage:@"bt_left02.png" target:self selector:@selector(selTrackPrev)];
        btprevSound.anchorPoint = ccp(0, 1);
        btprevSound.scale = kXForIPhone;
        btprevSound.position = ccp(220 * kXForIPhone, 517 * kYForIPhone);
        
        btnextSound = [CCMenuItemImage itemFromNormalImage:@"bt_right01.png" selectedImage:@"bt_right02.png" target:self selector:@selector(selTrackNext)];
        btnextSound.anchorPoint = ccp(0, 1);
        btnextSound.scale = kXForIPhone;
        btnextSound.position = ccp(728 * kXForIPhone, 517 * kYForIPhone);
        
        lbTrack = [CCLabelTTF labelWithString:@"Challenge 1" dimensions:CGSizeMake(SCREEN_WIDTH, 50) alignment:CCTextAlignmentCenter fontName:@"arial" fontSize:40];
        lbTrack.anchorPoint = ccp(0.5, 1);
        lbTrack.position = ccp(SCREEN_WIDTH / 2, 495* kYForIPhone);
        lbTrack.scale = kXForIPhone;
        ccColor3B col = {0, 90, 0};
        [lbTrack setColor:col];
        [self addChild:lbTrack];
        [self updateTrack];
        
        btprevSmoke = [CCMenuItemImage itemFromNormalImage:@"bt_left01.png" selectedImage:@"bt_left02.png" target:self selector:@selector(selSmokel)];
        btprevSmoke.anchorPoint = ccp(0, 1);
        btprevSmoke.scale = kXForIPhone;
        btprevSmoke.position = ccp(220 * kXForIPhone, 366 * kYForIPhone);
        
        btnextSmoke = [CCMenuItemImage itemFromNormalImage:@"bt_right01.png" selectedImage:@"bt_right02.png" target:self selector:@selector(selSmoker)];
        btnextSmoke.anchorPoint = ccp(0, 1);
        btnextSmoke.scale = kXForIPhone;
        btnextSmoke.position = ccp(728 * kXForIPhone, 366 * kYForIPhone);
        
        lbSmoke = [CCLabelTTF labelWithString:@"Blue Hero" dimensions:CGSizeMake(SCREEN_WIDTH, 50) alignment:CCTextAlignmentCenter fontName:@"arial" fontSize:40];
        lbSmoke.anchorPoint = ccp(0.5, 1);
        lbSmoke.position = ccp(SCREEN_WIDTH / 2, 340 * kYForIPhone);
        lbSmoke.scale = kXForIPhone;
        [lbSmoke setColor:col];
        [self addChild:lbSmoke];
        chracter=1;
        [self updateBlood];

        btPlay = [CCMenuItemImage itemFromNormalImage:@"bt_play01.png" selectedImage:@"bt_play02.png" target:self selector:@selector(selPlay)];
        btPlay.anchorPoint = ccp(0, 1);
        btPlay.scale = kXForIPhone;
        btPlay.position = ccp(380 * kXForIPhone, 228 * kYForIPhone);
        
       /* btGetIt = [CCMenuItemImage itemFromNormalImage:@"bt_getit01.png" selectedImage:@"bt_getit02.png" target:self selector:@selector(selGetIt)];
        btGetIt.anchorPoint = ccp(0, 1);
        btGetIt.scale = kXForIPhone;
        btGetIt.position = ccp(423 * kXForIPhone, 228 * kYForIPhone);
        btGetIt.visible = NO;
*/
        CCMenu *menu = [CCMenu menuWithItems:btPlay, btnextSmoke, btnextSound, btprevSmoke, btprevSound, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu];

    }
    return self;
}

-(void) updateTrack
{
    if (g_gameInfo.trackNum > TRACK_COUNT - 1) {
        g_gameInfo.trackNum = 0;
    }
    if (g_gameInfo.trackNum < 0) {
        g_gameInfo.trackNum = TRACK_COUNT - 1;
    }

    [lbTrack setString:[NSString stringWithFormat:@"Challenge %d", g_gameInfo.trackNum + 1]];
}
-(void) updateBlood
{
    if (chracter==1) {
        [lbSmoke setString:@"Blue Hero"];
    }
    else if (chracter==2) {
        [lbSmoke setString:@"Red Hero"];
    }
    else if (chracter==3) {
        [lbSmoke setString:@"Yellow Hero"];
    }
    else if (chracter==4) {
        [lbSmoke setString:@"Blue Bike Hero"];
    }
    else if (chracter==5) {
        [lbSmoke setString:@"Red Bike Hero"];
    }
    else if (chracter==6) {
        [lbSmoke setString:@"Yellow Bike Hero"];
    }
}
-(void) selTrackNext
{
    [sd_button play];

    g_gameInfo.trackNum ++;
    [self updateTrack];
}
-(void) selTrackPrev
{
    [sd_button play];

    g_gameInfo.trackNum --;
    [self updateTrack];
}
-(void) selSmokel
{
    if (chracter==1) {
        chracter=7;
    }
    chracter--;
    [sd_button play];
    [self updateBlood];
}
-(void) selSmoker
{
    if (chracter==6) {
        chracter=0;
    }
    chracter++;
    [sd_button play];
    [self updateBlood];
}

-(void) selPlay
{
    [sd_button play];
    if( !game_initialize() ){
		NSLog(@"App Init Fail !/////////////");
		exit(0);
	}
    [self hideButtons];
    [[CCDirector sharedDirector] replaceScene:[GameLayer node]];
}
-(void) setEnableMenuItems:(BOOL) flag
{
    if (flag == TRUE) {
        [btprevSound setIsEnabled:YES];
        [btnextSound setIsEnabled:YES];
        [btprevSmoke setIsEnabled:YES];
        [btnextSmoke setIsEnabled:YES];
        [btPlay setIsEnabled:YES];
    }
    else
    {
        [btprevSound setIsEnabled:NO];
        [btnextSound setIsEnabled:NO];
        [btprevSmoke setIsEnabled:NO];
        [btnextSmoke setIsEnabled:NO];
        [btPlay setIsEnabled:NO];
    }
}
-(void) updateInAppResult
{
    if (g_gameInfo.isGetBloodINAPP == YES) {
        btPlay.visible = YES;
        btGetIt.visible = NO;
    }
    else {
        btPlay.visible = NO;
        btGetIt.visible = YES;
    }
}
-(void) selGetIt
{/*
    [[MKStoreManager sharedManager] buyFeature:@"com.semanticnotion.lol.removeads"
                                    onComplete:^(NSString* purchasedFeature,
                                                 NSData* purchasedReceipt,
                                                 NSArray* availableDownloads)
     {
         NSLog(@"Purchased: %@", purchasedFeature);
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Purchase was successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [alert release];
         saveUserInfo();
         NSLog(@"true");
    }
                                   onCancelled:^
     {
         NSLog(@"Something went wrong");
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong.\nPlease try again in a moment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [alert release];
     }];
    if([MKStoreManager isFeaturePurchased:@"com.semanticnotion.lol.removeads"])
    {
        NSLog(@"true");
        saveUserInfo();
    }
   */

}
-(void) showButtons
{
    selectTrack.visible = YES;
    lbTrack.visible = YES;
    lbSmoke.visible = YES;

    [btprevSound runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(SCREEN_WIDTH, 0)]];
    [btnextSound runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(-SCREEN_WIDTH, 0)]];
    [btprevSmoke runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(SCREEN_WIDTH, 0)]];
    [btnextSmoke runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(-SCREEN_WIDTH, 0)]];
//    [btPlay runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(0, -SCREEN_HEIGHT)]];
    btPlay.visible = YES;
    [btPlay runAction:[CCScaleTo actionWithDuration:0.5f scale:kXForIPhone]];

}
-(void) hideButtons
{
    selectTrack.visible = NO;
    lbTrack.visible = NO;
    lbSmoke.visible = NO;
    
    btprevSound.position = ccp(220 * kXForIPhone - SCREEN_WIDTH, 517 * kYForIPhone);
    btnextSound.position = ccp(728 * kXForIPhone + SCREEN_WIDTH, 517 * kYForIPhone);
    btprevSmoke.position = ccp(220 * kXForIPhone - SCREEN_WIDTH, 366 * kYForIPhone);
    btnextSmoke.position = ccp(728 * kXForIPhone + SCREEN_WIDTH, 366 * kYForIPhone);
//    btPlay.position = ccp(423 * kXForIPhone, 228 * kYForIPhone + SCREEN_HEIGHT);
    btPlay.visible = NO;
    btPlay.scale = 0.1 * kXForIPhone;
}

#pragma mark REMOVE CACHE

-(void)removeSprite:(CCSprite*)sp
{
    CCTexture2D *tex = [sp texture];
    [[CCTextureCache sharedTextureCache] removeTexture:tex];
    [sp removeFromParentAndCleanup:YES];
}

-(void)removeCache
{
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
    [self removeCache];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
