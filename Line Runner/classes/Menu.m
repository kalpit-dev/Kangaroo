//
//  Menu.m
//  Line Runner!
//
//  Created by Yang yang on 1/29/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import "Menu.h"
#import "Setting.h"
#import "Options.h"
#import "Tutorial.h"
#import "Play.h"
#import "AppDelegate.h"
#import "MKStoreManager.h"

#define POS_OPTION      (SCREEN_HEIGHT * 5 / 6)
#define POS_TUTORIAL    (SCREEN_HEIGHT * 4 / 6)
#define POS_PLAY        (SCREEN_HEIGHT * 2 / 6)

@implementation Menu


-(id) init
{
	if( (self=[super init])) {
        
        self.isTouchEnabled = YES;
        CCSprite *sp1 = [CCSprite spriteWithFile:@"cloud1.png"]; //rect:CGRectMake(0, 846, 1024, 178)];
        sp1.position = ccp(200 * kXForIPhone, 650 * kYForIPhone);
        sp1.scaleX = kXForIPhone;
        sp1.scaleY = kYForIPhone;
        [self addChild:sp1 z:-1];
        
        CCSprite *sp2 = [CCSprite spriteWithFile:@"cloud2.png"]; //rect:CGRectMake(0, 846, 1024, 178)];
        sp2.position = ccp(500 * kXForIPhone, 600 * kYForIPhone);
        sp2.scaleX = kXForIPhone;
        sp2.scaleY = kYForIPhone;
        [self addChild:sp2 z:-1];
        
        CCSprite *sp3 = [CCSprite spriteWithFile:@"cloud3.png"]; ///rect:CGRectMake(0, 846, 1024, 178)];
        sp3.position = ccp(900 * kXForIPhone, 650 * kYForIPhone);
        sp3.scaleX = kXForIPhone;
        sp3.scaleY = kYForIPhone;
        [self addChild:sp3 z:-1];

        text02 = [CCSprite spriteWithFile: @"text02.png"];
      //  text02.anchorPoint = ccp(0, 1);
        text02.scale = kXForIPhone;
        text02.position = ccp(550 * kXForIPhone + SCREEN_WIDTH, 580 * kYForIPhone);
        [self addChild: text02];

        text01 = [CCSprite spriteWithFile:@"text01.png"];
        text01.anchorPoint = ccp(0, 1);
        text01.scale = kXForIPhone;
        text01.position = ccp(152 * kXForIPhone - SCREEN_WIDTH, 700 * kYForIPhone);
        [self addChild: text01];
        
        btOptions = [CCMenuItemImage itemFromNormalImage:@"bt_option01.png" selectedImage:@"bt_option02.png" target:self selector:@selector(selOptions)];
        btOptions.anchorPoint = ccp(0, 1);
        btOptions.scale = kXForIPhone;
        btOptions.position = ccp(380 * kXForIPhone, 230 * kYForIPhone - SCREEN_HEIGHT);
        
        btTutorial  = [CCMenuItemImage itemFromNormalImage:@"bt_help01.png" selectedImage:@"bt_help02.png" target:self selector:@selector(selTutorial)];
        btTutorial.anchorPoint = ccp(0, 1);
        btTutorial.scale = kXForIPhone;
        btTutorial.position = ccp(380 * kXForIPhone, 330 * kYForIPhone - SCREEN_HEIGHT);

        btPlay = [CCMenuItemImage itemFromNormalImage:@"bt_play01.png" selectedImage:@"bt_play02.png" target:self selector:@selector(selPlay)];
        btPlay.scale = kXForIPhone;
        btPlay.position = ccp(380 * kXForIPhone, 430 * kYForIPhone - SCREEN_HEIGHT);
        btPlay.anchorPoint = ccp(0, 1);
        
              /* btFaceBook = [CCMenuItemImage itemFromNormalImage:@"bt_facebook01.png" selectedImage:@"bt_facebook02.png" target:self selector:@selector(selFaceBook)];
        btFaceBook.scale = kXForIPhone;
        btFaceBook.position = ccp(33 * kXForIPhone, 126 * kYForIPhone - SCREEN_HEIGHT);
        btFaceBook.anchorPoint = ccp(0, 1);

        btTwitter = [CCMenuItemImage itemFromNormalImage:@"bt_twitter01.png" selectedImage:@"bt_twitter02.png" target:self selector:@selector(selTwitter)];
        btTwitter.scale = kXForIPhone;
        btTwitter.position = ccp(153 * kXForIPhone, 126 * kYForIPhone - SCREEN_HEIGHT);
        btTwitter.anchorPoint = ccp(0, 1);
        */
        CCMenu *menu = [CCMenu menuWithItems:btOptions, btTutorial, btPlay, /*btFaceBook, btTwitter,*/ nil];
        menu.position = CGPointZero;
        [self addChild:menu z:3];
        
        morescreen = [CCMenuItemImage itemFromNormalImage:@"freegame.png" selectedImage:@"freegame.png" target:self selector:@selector(selfreegame)];
        morescreen.scale = kXForIPhone;
        morescreen.position = ccp(120 * kXForIPhone, 640 * kYForIPhone);
        morescreen.touchArea = CGRectMake(0,10,(morescreen.contentSize.width-morescreen.contentSize.width/2)+20 ,morescreen.contentSize.height);
        
                                         // morescreen.contentSize.width - morescreen.contentSize.width/2, morescreen.contentSize.height - morescreen.contentSize.height/2,
        
        CCMenu *freemenu = [CCMenu menuWithItems:morescreen, nil];
        freemenu.position = CGPointZero;
        [self addChild:freemenu];
        
        optionsLayer = [Options node];
        optionsLayer.parentMenu = self;
        [optionsLayer hideButtons];
        [self addChild:optionsLayer];
        
        tutorialLayer = [Tutorial node];
        tutorialLayer.parentMenu = self;
        [tutorialLayer hideButtons];
        [self addChild:tutorialLayer];
        
        playLayer = [Play node];
        playLayer.parentMenu = self;
        [playLayer hideButtons];
        [self addChild:playLayer];
        
        [self showButtons];
        road = [CCSprite spriteWithFile:@"road.png"];//rect:CGRectMake(0, 768, 1024, 24)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            road.position = ccp(SCREEN_WIDTH / 2, 120 * kYForIPhone);
        }
        else {
            road.position = ccp(SCREEN_WIDTH / 2, 100 * kYForIPhone);
        }
        road.scaleX = kXForIPhone;
        road.scaleY = kYForIPhone;
        [self addChild:road z:2];
#ifdef FreeApp
        if (lockads==FALSE) {
            
        CCMenuItemImage *item3 = [CCMenuItemImage itemFromNormalImage:@"remove.png" selectedImage:@"remove.png" target:self selector:@selector(removeadds:)];
        item3.scale = kXForIPhone;
        item3.position = ccp(860 * kXForIPhone, 30 * kYForIPhone);
        CCMenuItemImage *item5 = [CCMenuItemImage itemFromNormalImage:@"restore.png" selectedImage:@"restore.png" target:self selector:@selector(restore:)];
        item5.scale = kXForIPhone;
        item5.position = ccp(130 * kXForIPhone, 30 * kYForIPhone);
        update_restore = [CCMenu menuWithItems:item3, item5, nil];
        update_restore.position = ccp(0,0);
            [self addChild:update_restore z:5];
        }
#endif
    }
 
    return self;
    
}


-(void)restore:(id)sender
{
#ifdef FreeApp
    [[MKStoreManager sharedManager] restorePreviousTransactionsOnComplete:^{
        
        if([MKStoreManager isFeaturePurchased: @"com.mastermindconsulting.kangaroosuperheroes.KangarooSuperHeroesPaid"] == NO) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to process your transaction.\nPlease try again in a moment." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Restore Completed" message:@"In app Purchase Remove Ads Restored" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            lockads=TRUE;
            [[NSUserDefaults standardUserDefaults] setBool:lockads forKey:@"lockads"];
            NSLog(@"true");
            [self removeChild:update_restore cleanup:YES];
        }
        
        
    } onError:^(NSError *A) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to process your transaction.\nPlease try again in a moment." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }];
#endif
}

-(void)removeadds:(id)sender
{
#ifdef FreeApp
    NSLog(@"removeadd");
    CCLOG(@"%s", __PRETTY_FUNCTION__);
    [[MKStoreManager sharedManager] buyFeature:@"com.mastermindconsulting.kangaroosuperheroes.KangarooSuperHeroesPaid"
                                    onComplete:^(NSString* purchasedFeature,
                                                 NSData* purchasedReceipt,
                                                 NSArray* availableDownloads)
     {
         NSLog(@"Purchased: %@", purchasedFeature);
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Purchase was successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [alert release];
         lockads=TRUE;
         [[NSUserDefaults standardUserDefaults] setBool:lockads forKey:@"lockads"];
         NSLog(@"true");
         [self removeChild:update_restore cleanup:YES];
     }
                                   onCancelled:^
     {
         NSLog(@"Something went wrong");
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong.\nPlease try again in a moment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [alert release];
     }];
    if([MKStoreManager isFeaturePurchased:@"com.mastermindconsulting.kangaroosuperheroes.KangarooSuperHeroesPaid"])
    {
        lockads=TRUE;
        [[NSUserDefaults standardUserDefaults] setBool:lockads forKey:@"lockads"];
        NSLog(@"true");
        [self removeChild:update_restore cleanup:YES];
    }
#endif
}

- (void)selfreegame
{
    NSLog(@"press");
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://cpapower.net/tracking/games/index.php"]];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app showingAddFromGame:FALSE];
}

-(void) selOptions
{
    [sd_button play];
    
    [self hideButtons];
    [optionsLayer showButtons];
    
}
-(void) selTutorial
{
    [sd_button play];

    [self hideButtons];
    [tutorialLayer showButtons];
}
-(void) selPlay
{
    [sd_button play];

    [self hideButtons];
    [playLayer showButtons];
}/*
-(void) selFaceBook
{
    [sd_button play];

}
-(void) selTwitter
{
    [sd_button play];

   
}*/
-(void) showButtons
{
    CCSequence *seq = [CCSequence actions:[CCMoveBy actionWithDuration:0.3f position:ccp(-SCREEN_WIDTH, 0)],
                       [CCCallFunc actionWithTarget:self selector:@selector(selShowText1)], nil];
    [text02 runAction:seq];
    
}
-(void) selShowText1
{
    
    CCSequence * seq = [CCSequence actions:[CCMoveBy actionWithDuration:0.3f position:ccp(SCREEN_WIDTH, 0)],
                        [CCCallFunc actionWithTarget:self selector:@selector(selShowButtons)], nil];
    [text01 runAction:seq];
}
-(void) selShowButtons
{
    update_restore.visible=YES;
    text01.visible=YES;
    text02.visible=YES;
    btOptions.visible=YES;
    road.visible=YES;
    btTutorial.visible=YES;
    btPlay.visible=YES;
    [btOptions runAction:[CCMoveBy actionWithDuration:0.3f position:ccp(0, SCREEN_HEIGHT)]];
    [btTutorial runAction:[CCMoveBy actionWithDuration:0.3f position:ccp(0, SCREEN_HEIGHT)]];
    [btPlay runAction:[CCMoveBy actionWithDuration:0.3f position:ccp(0, SCREEN_HEIGHT)]];
  //  [btFaceBook runAction:[CCMoveBy actionWithDuration:0.3f position:ccp(0, SCREEN_HEIGHT)]];
 //   [btTwitter runAction:[CCMoveBy actionWithDuration:0.3f position:ccp(0, SCREEN_HEIGHT)]];

}
-(void) hideButtons
{
    update_restore.visible=NO;
    text01.visible=NO;
    text02.visible=NO;
    btOptions.visible=NO;
    road.visible=NO;
    btTutorial.visible=NO;
    btPlay.visible=NO;
    
    text02.position = ccp(550 * kXForIPhone + SCREEN_WIDTH, 580 * kYForIPhone);
    text01.position = ccp(152 * kXForIPhone - SCREEN_WIDTH, 700 * kYForIPhone);

    btTutorial.position = ccp(380 * kXForIPhone, 330 * kYForIPhone - SCREEN_HEIGHT);
    btOptions.position = ccp(380 * kXForIPhone, 230 * kYForIPhone - SCREEN_HEIGHT);
    btPlay.position = ccp(380 * kXForIPhone, 430 * kYForIPhone - SCREEN_HEIGHT);
  //  btFaceBook.position = ccp(33 * kXForIPhone, 126 * kYForIPhone - SCREEN_HEIGHT);
  //  btTwitter.position = ccp(153 * kXForIPhone, 126 * kYForIPhone - SCREEN_HEIGHT);

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
    [self removeSprite:text01];
    [self removeSprite:text02];
    
    [self removeSprite:(CCSprite*)[btOptions normalImage]];
    [self removeSprite:(CCSprite*)[btOptions selectedImage]];
    [btOptions removeFromParentAndCleanup:YES];
    
    [self removeSprite:(CCSprite*)[btTutorial normalImage]];
    [self removeSprite:(CCSprite*)[btTutorial selectedImage]];
    [btTutorial removeFromParentAndCleanup:YES];
    
    [self removeSprite:(CCSprite*)[btPlay normalImage]];
    [self removeSprite:(CCSprite*)[btPlay selectedImage]];
    [btPlay removeFromParentAndCleanup:YES];
/*
    [self removeSprite:(CCSprite*)[btFaceBook normalImage]];
    [self removeSprite:(CCSprite*)[btFaceBook selectedImage]];
    [btFaceBook removeFromParentAndCleanup:YES];

    [self removeSprite:(CCSprite*)[btTwitter normalImage]];
    [self removeSprite:(CCSprite*)[btTwitter selectedImage]];
    [btTwitter removeFromParentAndCleanup:YES];
  */  
    [self removeSprite:(CCSprite*)[morescreen normalImage]];
    [self removeSprite:(CCSprite*)[morescreen selectedImage]];
    [morescreen removeFromParentAndCleanup:YES];
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
/*
btOptions = [CCMenuItemImage itemFromNormalImage:@"bt_option01.png" selectedImage:@"bt_option02.png" target:self selector:@selector(selOptions)];
btOptions.anchorPoint = ccp(0, 1);
btOptions.scale = kXForIPhone;
btOptions.position = ccp(20 * kXForIPhone, 520 * kYForIPhone - SCREEN_HEIGHT);

btTutorial  = [CCMenuItemImage itemFromNormalImage:@"bt_help01.png" selectedImage:@"bt_help02.png" target:self selector:@selector(selTutorial)];
btTutorial.anchorPoint = ccp(0, 1);
btTutorial.scale = kXForIPhone;
btTutorial.position = ccp(20 * kXForIPhone, 450 * kYForIPhone - SCREEN_HEIGHT);

btPlay = [CCMenuItemImage itemFromNormalImage:@"bt_play01.png" selectedImage:@"bt_play02.png" target:self selector:@selector(selPlay)];
btPlay.scale = kXForIPhone;
btPlay.position = ccp(20 * kXForIPhone, 380 * kYForIPhone - SCREEN_HEIGHT);
btPlay.anchorPoint = ccp(0, 1);

*/


