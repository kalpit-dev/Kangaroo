//
//  Options.m
//  Line Runner!
//
//  Created by Yang yang on 1/29/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import "Options.h"
#import "Setting.h"

#define POS_X_PREV_SOUND    (229 * kXForIPhone)
#define POS_Y_PREV_SOUND    (521 * kYForIPhone)

#define POS_X_NEXT_SOUND    (738 * kXForIPhone)
#define POS_Y_NEXT_SMOKE    (SCREEN_HEIGHT * 4 / 7)

#define POS_BACK        (SCREEN_HEIGHT * 1 / 6)


@implementation Options

@synthesize parentMenu;

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
    
        self.isTouchEnabled = YES;

        options = [CCSprite spriteWithFile:@"t_options.png"];
        options.anchorPoint = ccp(0, 1);
        options.scale = kXForIPhone;
        options.position = ccp(380 * kXForIPhone, 633 * kYForIPhone);
        [self addChild:options];
        
        btprevSound = [CCMenuItemImage itemFromNormalImage:@"bt_left01.png" selectedImage:@"bt_left02.png" target:self selector:@selector(selSound)];
        btprevSound.anchorPoint = ccp(0, 1);
        btprevSound.scale = kXForIPhone;
        btprevSound.position = ccp(POS_X_PREV_SOUND, POS_Y_PREV_SOUND);
        
        btnextSound = [CCMenuItemImage itemFromNormalImage:@"bt_right01.png" selectedImage:@"bt_right02.png" target:self selector:@selector(selSound)];
        btnextSound.anchorPoint = ccp(0, 1);
        btnextSound.scale = kXForIPhone;
        btnextSound.position = ccp(POS_X_NEXT_SOUND, POS_Y_PREV_SOUND);

        btBack = [CCMenuItemImage itemFromNormalImage:@"bt_back01.png" selectedImage:@"bt_back02.png" target:self selector:@selector(selBack)];
        btBack.anchorPoint = ccp(0, 1);
        btBack.scale = kXForIPhone;
        btBack.position = ccp(380 * kXForIPhone, 184 * kYForIPhone);
        btBack.scale = 0.1 * kXForIPhone;
        
        CCMenu *menu = [CCMenu menuWithItems:btBack, btnextSound, btprevSound, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu];
        
        lbSound = [CCLabelTTF labelWithString:@"Sound:" dimensions:CGSizeMake(SCREEN_WIDTH, 60) alignment:CCTextAlignmentCenter fontName:@"arial" fontSize:40];
        lbSound.anchorPoint = ccp(0.5, 1);
        lbSound.position = ccp(SCREEN_WIDTH / 2, 500 * kYForIPhone);
        lbSound.scale = kXForIPhone;
        ccColor3B col = {0, 90, 0};
        [lbSound setColor:col];
        [self addChild:lbSound];
        [self updateSoundLabel];
        
        
    }
 
    return self;
}

-(void)onEnter
{
    [super onEnter];
}
-(void) updateSoundLabel
{
    if (g_gameInfo.isSoundOn == YES) {
        [lbSound setString: [NSString stringWithFormat:@"Sound: on"]];
    }
    else  {
        [lbSound setString: [NSString stringWithFormat:@"Sound: off"]];
    }
}
-(void) selSound
{
    [sd_button play];

    g_gameInfo.isSoundOn = !g_gameInfo.isSoundOn;
    allSoundPause();
    [self updateSoundLabel];
}
-(void) selBack
{
    [sd_button play];

    [self hideButtons];
    [parentMenu showButtons];
}
-(void) showButtons
{
    options.visible = YES;
    lbSound.visible = YES;
    [btprevSound runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(SCREEN_WIDTH, 0)]];
    [btnextSound runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(-SCREEN_WIDTH, 0)]];
//    [btBack runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(0, -SCREEN_HEIGHT)]];
    btBack.visible = YES;
    [btBack runAction:[CCScaleTo actionWithDuration:0.5f scale:kXForIPhone]];
}
-(void) hideButtons
{
    options.visible = NO;
    lbSound.visible = NO;
    btprevSound.position = ccp(POS_X_PREV_SOUND - SCREEN_WIDTH, POS_Y_PREV_SOUND);
    btnextSound.position = ccp(POS_X_NEXT_SOUND + SCREEN_WIDTH, POS_Y_PREV_SOUND);
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
    [self removeSprite:options];
    
    [self removeSprite:(CCSprite*)[btBack normalImage]];
    [self removeSprite:(CCSprite*)[btBack selectedImage]];
    [btBack removeFromParentAndCleanup:YES];

    [self removeSprite:(CCSprite*)[btprevSound normalImage]];
    [self removeSprite:(CCSprite*)[btprevSound selectedImage]];
    [btprevSound removeFromParentAndCleanup:YES];

    [self removeSprite:(CCSprite*)[btnextSound normalImage]];
    [self removeSprite:(CCSprite*)[btnextSound selectedImage]];
    [btnextSound removeFromParentAndCleanup:YES];

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
