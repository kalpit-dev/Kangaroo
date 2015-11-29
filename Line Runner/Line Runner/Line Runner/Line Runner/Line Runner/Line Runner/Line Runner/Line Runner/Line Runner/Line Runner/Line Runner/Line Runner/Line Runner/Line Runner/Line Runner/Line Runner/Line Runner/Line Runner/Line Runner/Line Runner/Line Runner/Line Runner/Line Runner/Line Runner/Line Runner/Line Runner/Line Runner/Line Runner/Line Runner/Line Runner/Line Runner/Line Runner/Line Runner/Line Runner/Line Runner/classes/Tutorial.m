//
//  Tutorial.m
//  Line Runner!
//
//  Created by Yang yang on 1/29/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import "Tutorial.h"
#import "Setting.h"
#import "Menu.h"

#define POS_BACK        (SCREEN_HEIGHT * 1 / 6)

@implementation Tutorial

@synthesize parentMenu;

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        self.isTouchEnabled = YES;
        
        tutorial = [CCSprite spriteWithFile:@"t_help.png"];
        tutorial.anchorPoint = ccp(0.5, 0);
        tutorial.scale = kXForIPhone;
        tutorial.position = ccp(SCREEN_WIDTH / 2, 0);
        [self addChild:tutorial];
        
        btBack = [CCMenuItemImage itemFromNormalImage:@"bt_back01.png" selectedImage:@"bt_back01.png" target:self selector:@selector(selBack)];
        btBack.anchorPoint = ccp(0, 1);
        btBack.scale = kXForIPhone;
        btBack.position = ccp(380 * kXForIPhone, 184 * kYForIPhone);
        btBack.scale = 0.1 * kXForIPhone;
        
        CCMenu *menu = [CCMenu menuWithItems:btBack, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu];

    }
    
    return self;
}

-(void) selBack
{
    [sd_button play];

    [self hideButtons];
    [parentMenu showButtons];

}
-(void) showButtons
{
    tutorial.visible = YES;
    btBack.visible = YES;
//    [btBack runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(0, -SCREEN_HEIGHT)]];
    [btBack runAction:[CCScaleTo actionWithDuration:0.5f scale:kXForIPhone]];

}
-(void) hideButtons
{
    tutorial.visible = NO;
//    btBack.position = ccp(440 * kXForIPhone, 184 * kYForIPhone + SCREEN_HEIGHT);
    btBack.visible = NO;
    btBack.scale = 0.1 * kXForIPhone;
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
    [self removeSprite: tutorial];
    
    [self removeSprite:(CCSprite*)[btBack normalImage]];
    [self removeSprite:(CCSprite*)[btBack selectedImage]];
    [btBack removeFromParentAndCleanup:YES];

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
