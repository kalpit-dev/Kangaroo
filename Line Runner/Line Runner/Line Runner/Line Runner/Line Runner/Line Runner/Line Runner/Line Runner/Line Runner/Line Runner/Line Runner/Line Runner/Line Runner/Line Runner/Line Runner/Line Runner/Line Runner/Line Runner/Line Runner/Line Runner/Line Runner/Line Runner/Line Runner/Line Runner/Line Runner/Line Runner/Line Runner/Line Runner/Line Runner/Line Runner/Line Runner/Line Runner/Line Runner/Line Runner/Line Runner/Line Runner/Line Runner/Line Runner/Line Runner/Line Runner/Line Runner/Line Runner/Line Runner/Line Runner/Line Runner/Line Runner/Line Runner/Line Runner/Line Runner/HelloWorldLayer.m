//
//  HelloWorldLayer.m
//  Line Runner
//
//  Created by Yang yang on 1/28/12.
//  Copyright physicsgametop 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "Menu.h"
#import "GameData.h"

// HelloWorldLayer implementation




@implementation HelloWorldLayer


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
       
		backArray = [[NSMutableArray alloc] init];
        frontArray = [[NSMutableArray alloc] init];
        
        self.isTouchEnabled = YES;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            SCREEN_WIDTH = 1024;
            SCREEN_HEIGHT = 768;
        }
        background = [CCSprite spriteWithFile:@"back_ipad.png" rect:CGRectMake(0, 0, 1024, 768)];
        background.position = ccp(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        background.scaleX = kXForIPhone;
        background.scaleY = kYForIPhone;
        [self addChild:background z:0];
                
               
        CCSprite *sp = [CCSprite spriteWithFile:@"front_mountion_ipad.png"];
        sp.position = ccp(SCREEN_WIDTH / 2, sp.contentSize.height / 2 * kYForIPhone);
        sp.scaleX = kXForIPhone;
        sp.scaleY = kYForIPhone+0.2;
        [self addChild:sp z:2];
        [frontArray addObject:sp];
        
        sp = [CCSprite spriteWithFile:@"front_mountion_ipad.png"];
        sp.position = ccp(SCREEN_WIDTH * 3 / 2, sp.contentSize.height / 2 * kYForIPhone);
        sp.scaleX = kXForIPhone;
        sp.scaleY = kYForIPhone+0.2;
        [self addChild:sp z:2];
        [frontArray addObject:sp];
        
        menuLayer = [Menu node];
        [self addChild:menuLayer z:5];
        
        [self schedule:@selector(onTime:)];
        
        sd_menuback.delegate = self;
        if (g_gameInfo.isSoundOn == YES) {
            [sd_menuback play];
        }
        
//        UIStoryboard *storyBoardForAdView = [UIStoryboard storyboardWithName:@"AddViewStoryboard" bundle:[NSBundle mainBundle]];
//        
//        UIViewController *viewControllerForAd = [storyBoardForAdView instantiateViewControllerWithIdentifier:@"AdViewController"];
//        
//        [[[CCDirector sharedDirector] openGLView].window.rootViewController presentViewController:viewControllerForAd animated:YES completion:nil];
        

	}
	return self;
}


-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)endedPlayer successfully:(BOOL)flag
{
    if (endedPlayer == sd_menuback) {
        [sd_menuback play];
    }
}
-(void) onTime:(ccTime) dt
{
    CGFloat frontDelta = VEL_FRONT_MOVE * dt;
    
    for (CCSprite *sp in frontArray) {
        
        if ( (sp.position.x + sp.contentSize.width / 2 * kXForIPhone) < 0) {
            sp.position = ccpAdd(sp.position, ccp(SCREEN_WIDTH * 2, 0));
        }
        
        sp.position = ccpSub(sp.position, ccp(frontDelta, 0));
    }
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
    [self removeSprite:background];
    
        
    for (CCSprite *sp in frontArray) {
        [self removeSprite:sp];
    }
    [frontArray removeAllObjects];
    [frontArray release];

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
    if ([sd_menuback isPlaying] == YES) {
        [sd_menuback pause];
    }
    [self removeCache];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
