//
//  GameLayer.m
//  Line Runner!
//
//  Created by Yang yang on 1/30/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import "GameLayer.h"
#import "Setting.h"
#import "GameData.h"
#import "HelloWorldLayer.h"
#import "Player.h"
//#import "SNAdsManager.h"
#import "RateManager.h"
//#import "LoadNextScreenComponents.h"
#import "MKStoreManager.h"

#define POS_X_PREV_SOUND    (SCREEN_WIDTH / 3)
#define POS_Y_PREV_SOUND    (SCREEN_HEIGHT * 5 / 7)

#define POS_X_NEXT_SOUND    (SCREEN_WIDTH / 3 * 2)
#define POS_Y_NEXT_SMOKE    (SCREEN_HEIGHT * 4 / 7)

#define ktrackingPixelCode @"trackedPixelsOnce"


CGPoint curDiePos;
extern int tapcount;

@implementation GameLayer

-(CGRect) sunRect:(CCSprite*) sp
{
    CGRect rt;
    CGSize sz = sp.contentSize;
    sz.width = sz.width * kXForIPhone;
    sz.height = sz.height * kYForIPhone;
    

    if (sp.position.y>LOAD_HEIGHT) {
        NSLog(@"%f",LOAD_HEIGHT);
        rt = CGRectMake(sp.position.x+15, sp.position.y+40, sz.width-15, sz.height-10);
        
    }
    else {
        if (sp.contentSize.width>80) {
            rt = CGRectMake(sp.position.x+20, sp.position.y, sz.width-20, sz.height-15);
        }
        else {
        rt = CGRectMake(sp.position.x+10, sp.position.y, sz.width-10, sz.height-10);
        }
    }
    
    return rt;
}

-(void) loadSuns
{
    if (sunArray != nil) {
        int arrayCount = [sunArray count];
        
        if (arrayCount > 0) {
            for (CCSprite *sun in sunArray) {
                [self removeSprite:sun];
            }
        }
        [sunArray removeAllObjects];
        [sunArray release];
        sunArray = nil;

    }
    
    sunArray = [[NSMutableArray alloc] init];
    CCSprite *sps;
    CCSprite *sp;
    switch (g_gameInfo.trackNum) {
        case 0:
            for (int i = 0; DATA_TRACK0[i][0] != 0; i ++) {
                int random = arc4random() % 10;
                if (random>-1 && random<4) {
                    sp = [CCSprite spriteWithFile:@"vlc.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK0[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK0[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK0[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>3 && random<7) {
                    sp = [CCSprite spriteWithFile:@"checkpoint.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK0[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK0[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK0[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>6 && random<10) {
                    sps = [CCSprite spriteWithFile:@"tgreen.png"];
                    sps.position = ccp(SCREEN_WIDTH + DATA_TRACK0[i][0] * kXForIPhone, LOAD_HEIGHT + DELTA_HEIGHT );
                    sps.scale = kXForIPhone;
                    sps.anchorPoint = ccp(0, 0);
                    [self addChild:sps];
                    [sunArray addObject:sps];
                    [[CCTextureCache sharedTextureCache] removeTexture:sps.texture];
                    [sps runAction:[CCRepeatForever actionWithAction:[[ani_sun copy] autorelease]]];
                }
            }

            break;
        case 1:
            for (int i = 0; DATA_TRACK1[i][0] != 0; i ++) {
                int random = arc4random() % 10;
                if (random>-1 && random<4) {
                    sp = [CCSprite spriteWithFile:@"vlc.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK1[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK1[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK1[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>3 && random<7) {
                    sp = [CCSprite spriteWithFile:@"checkpoint.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK1[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK1[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK1[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>6 && random<10) {
                    sps = [CCSprite spriteWithFile:@"tgreen.png"];
                    sps.position = ccp(SCREEN_WIDTH + DATA_TRACK1[i][0] * kXForIPhone, LOAD_HEIGHT + DELTA_HEIGHT );
                    sps.scale = kXForIPhone;
                    sps.anchorPoint = ccp(0, 0);
                    [self addChild:sps];
                    [sunArray addObject:sps];
                    [[CCTextureCache sharedTextureCache] removeTexture:sps.texture];
                    [sps runAction:[CCRepeatForever actionWithAction:[[ani_sun copy] autorelease]]];
                }
            }
            
            break;
        case 2:
            for (int i = 0; DATA_TRACK2[i][0] != 0; i ++) {
                int random = arc4random() % 10;
                if (random>-1 && random<4) {
                    sp = [CCSprite spriteWithFile:@"vlc.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK2[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK2[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK2[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>3 && random<7) {
                    sp = [CCSprite spriteWithFile:@"checkpoint.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK2[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK2[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK2[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>6 && random<10) {
                    sps = [CCSprite spriteWithFile:@"tgreen.png"];
                    sps.position = ccp(SCREEN_WIDTH + DATA_TRACK2[i][0] * kXForIPhone, LOAD_HEIGHT + DELTA_HEIGHT );
                    sps.scale = kXForIPhone;
                    sps.anchorPoint = ccp(0, 0);
                    [self addChild:sps];
                    [sunArray addObject:sps];
                    [[CCTextureCache sharedTextureCache] removeTexture:sps.texture];
                    [sps runAction:[CCRepeatForever actionWithAction:[[ani_sun copy] autorelease]]];
                }
            }
            
            break;
        case 3:
            for (int i = 0; DATA_TRACK3[i][0] != 0; i ++) {
                int random = arc4random() % 10;
                if (random>-1 && random<4) {
                    sp = [CCSprite spriteWithFile:@"vlc.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK3[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK3[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK3[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>3 && random<7) {
                    sp = [CCSprite spriteWithFile:@"checkpoint.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK3[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK3[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK3[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>6 && random<10) {
                    sps = [CCSprite spriteWithFile:@"tgreen.png"];
                    sps.position = ccp(SCREEN_WIDTH + DATA_TRACK3[i][0] * kXForIPhone, LOAD_HEIGHT + DELTA_HEIGHT );
                    sps.scale = kXForIPhone;
                    sps.anchorPoint = ccp(0, 0);
                    [self addChild:sps];
                    [sunArray addObject:sps];
                    [[CCTextureCache sharedTextureCache] removeTexture:sps.texture];
                    [sps runAction:[CCRepeatForever actionWithAction:[[ani_sun copy] autorelease]]];
                }
            }
            
            break;
        case 4:
            for (int i = 0; DATA_TRACK4[i][0] != 0; i ++) {
                int random = arc4random() % 10;
                if (random>-1 && random<4) {
                    sp = [CCSprite spriteWithFile:@"vlc.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK4[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK4[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK4[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>3 && random<7) {
                    sp = [CCSprite spriteWithFile:@"checkpoint.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK4[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK4[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK4[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>6 && random<10) {
                    sps = [CCSprite spriteWithFile:@"tgreen.png"];
                    sps.position = ccp(SCREEN_WIDTH + DATA_TRACK4[i][0] * kXForIPhone, LOAD_HEIGHT + DELTA_HEIGHT );
                    sps.scale = kXForIPhone;
                    sps.anchorPoint = ccp(0, 0);
                    [self addChild:sps];
                    [sunArray addObject:sps];
                    [[CCTextureCache sharedTextureCache] removeTexture:sps.texture];
                    [sps runAction:[CCRepeatForever actionWithAction:[[ani_sun copy] autorelease]]];
                }
            }
            
            break;
        case 5:
            for (int i = 0; DATA_TRACK5[i][0] != 0; i ++) {
                int random = arc4random() % 10;
                if (random>-1 && random<4) {
                    sp = [CCSprite spriteWithFile:@"vlc.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK5[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK5[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK5[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>3 && random<7) {
                    sp = [CCSprite spriteWithFile:@"checkpoint.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK5[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK5[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK5[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>6 && random<10) {
                    sps = [CCSprite spriteWithFile:@"tgreen.png"];
                    sps.position = ccp(SCREEN_WIDTH + DATA_TRACK5[i][0] * kXForIPhone, LOAD_HEIGHT + DELTA_HEIGHT );
                    sps.scale = kXForIPhone;
                    sps.anchorPoint = ccp(0, 0);
                    [self addChild:sps];
                    [sunArray addObject:sps];
                    [[CCTextureCache sharedTextureCache] removeTexture:sps.texture];
                    [sps runAction:[CCRepeatForever actionWithAction:[[ani_sun copy] autorelease]]];
                }
            }
            
            break;
        case 6:
            for (int i = 0; DATA_TRACK6[i][0] != 0; i ++) {
                int random = arc4random() % 10;
                if (random>-1 && random<4) {
                    sp = [CCSprite spriteWithFile:@"vlc.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK6[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK6[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK6[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>3 && random<7) {
                    sp = [CCSprite spriteWithFile:@"checkpoint.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK6[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK6[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK6[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>6 && random<10) {
                    sps = [CCSprite spriteWithFile:@"tgreen.png"];
                    sps.position = ccp(SCREEN_WIDTH + DATA_TRACK6[i][0] * kXForIPhone, LOAD_HEIGHT + DELTA_HEIGHT );
                    sps.scale = kXForIPhone;
                    sps.anchorPoint = ccp(0, 0);
                    [self addChild:sps];
                    [sunArray addObject:sps];
                    [[CCTextureCache sharedTextureCache] removeTexture:sps.texture];
                    [sps runAction:[CCRepeatForever actionWithAction:[[ani_sun copy] autorelease]]];
                }
            }
            
            break;
        case 7:
            for (int i = 0; DATA_TRACK7[i][0] != 0; i ++) {
                int random = arc4random() % 10;
                if (random>-1 && random<4) {
                    sp = [CCSprite spriteWithFile:@"vlc.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK7[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK7[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK7[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>3 && random<7) {
                    sp = [CCSprite spriteWithFile:@"checkpoint.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK7[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK7[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK7[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>6 && random<10) {
                    sps = [CCSprite spriteWithFile:@"tgreen.png"];
                    sps.position = ccp(SCREEN_WIDTH + DATA_TRACK7[i][0] * kXForIPhone, LOAD_HEIGHT + DELTA_HEIGHT );
                    sps.scale = kXForIPhone;
                    sps.anchorPoint = ccp(0, 0);
                    [self addChild:sps];
                    [sunArray addObject:sps];
                    [[CCTextureCache sharedTextureCache] removeTexture:sps.texture];
                    [sps runAction:[CCRepeatForever actionWithAction:[[ani_sun copy] autorelease]]];
                }
            }
            
            break;
        case 8:
            for (int i = 0; DATA_TRACK8[i][0] != 0; i ++) {
                int random = arc4random() % 10;
                if (random>-1 && random<4) {
                    sp = [CCSprite spriteWithFile:@"vlc.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK8[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK8[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK8[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>3 && random<7) {
                    sp = [CCSprite spriteWithFile:@"checkpoint.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK8[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK8[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK8[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>6 && random<10) {
                    sps = [CCSprite spriteWithFile:@"tgreen.png"];
                    sps.position = ccp(SCREEN_WIDTH + DATA_TRACK8[i][0] * kXForIPhone, LOAD_HEIGHT + DELTA_HEIGHT );
                    sps.scale = kXForIPhone;
                    sps.anchorPoint = ccp(0, 0);
                    [self addChild:sps];
                    [sunArray addObject:sps];
                    [[CCTextureCache sharedTextureCache] removeTexture:sps.texture];
                    [sps runAction:[CCRepeatForever actionWithAction:[[ani_sun copy] autorelease]]];
                }
            }
            
            break;
        case 9:
            for (int i = 0; DATA_TRACK9[i][0] != 0; i ++) {
                int random = arc4random() % 10;
                if (random>-1 && random<4) {
                    sp = [CCSprite spriteWithFile:@"vlc.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK9[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK9[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK9[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>3 && random<7) {
                    sp = [CCSprite spriteWithFile:@"checkpoint.png"];
                    sp.scale = kXForIPhone;
                    sp.anchorPoint = ccp(0, 0);
                    
                    if (DATA_TRACK9[i][1] == 0) {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK9[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    else {
                        sp.position = ccp(SCREEN_WIDTH + DATA_TRACK9[i][0] * kXForIPhone, LOAD_HEIGHT );
                    }
                    [self addChild:sp];
                    [sunArray addObject:sp];
                    [[CCTextureCache sharedTextureCache] removeTexture:sp.texture];
                }
                else if (random>6 && random<10) {
                    sps = [CCSprite spriteWithFile:@"tgreen.png"];
                    sps.position = ccp(SCREEN_WIDTH + DATA_TRACK9[i][0] * kXForIPhone, LOAD_HEIGHT + DELTA_HEIGHT );
                    sps.scale = kXForIPhone;
                    sps.anchorPoint = ccp(0, 0);
                    [self addChild:sps];
                    [sunArray addObject:sps];
                    [[CCTextureCache sharedTextureCache] removeTexture:sps.texture];
                    [sps runAction:[CCRepeatForever actionWithAction:[[ani_sun copy] autorelease]]];
                }
            }
            break;

        default:
            break;
    }
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		backArray = [[NSMutableArray alloc] init];
        frontArray = [[NSMutableArray alloc] init];
        
        if (lockads==FALSE) {
           // [[SNAdsManager sharedManager] giveMeBannerAd];
        }
        self.isTouchEnabled = YES;
        tapcount=0;
        background = [CCSprite spriteWithFile:@"back_ipad.png" rect:CGRectMake(0, 0, 1024, 768)];
        background.position = ccp(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        background.scaleX = kXForIPhone;
        background.scaleY = kYForIPhone;
        [self addChild:background];
        
        CCSprite *sp1 = [CCSprite spriteWithFile:@"cloud1.png"]; //rect:CGRectMake(0, 846, 1024, 178)];
        sp1.position = ccp(200 * kXForIPhone, 650 * kYForIPhone);
        sp1.scaleX = kXForIPhone;
        sp1.scaleY = kYForIPhone;
        [self addChild:sp1 z:0];
        
        CCSprite *sp2 = [CCSprite spriteWithFile:@"cloud2.png"]; //rect:CGRectMake(0, 846, 1024, 178)];
        sp2.position = ccp(500 * kXForIPhone, 600 * kYForIPhone);
        sp2.scaleX = kXForIPhone;
        sp2.scaleY = kYForIPhone;
        [self addChild:sp2 z:0];
        
        CCSprite *sp3 = [CCSprite spriteWithFile:@"cloud3.png"]; ///rect:CGRectMake(0, 846, 1024, 178)];
        sp3.position = ccp(900 * kXForIPhone, 650 * kYForIPhone);
        sp3.scaleX = kXForIPhone;
        sp3.scaleY = kYForIPhone;
        [self addChild:sp3 z:0];
        
        CCSprite *sp = [CCSprite spriteWithFile:@"back_ipad.png" rect:CGRectMake(0, 846, 1024, 178)];
        sp.position = ccp(SCREEN_WIDTH / 2, sp.contentSize.height / 2 * kYForIPhone);
        sp.scaleX = kXForIPhone;
        sp.scaleY = kYForIPhone;
        [self addChild:sp];
        [backArray addObject:sp];
        
        sp = [CCSprite spriteWithFile:@"back_ipad.png" rect:CGRectMake(0, 846, 1024, 178)];
        sp.position = ccp(SCREEN_WIDTH * 3 / 2, sp.contentSize.height / 2 * kYForIPhone);
        sp.scaleX = kXForIPhone;
        sp.scaleY = kYForIPhone;
        [self addChild:sp];
        [backArray addObject:sp]; 
        
        sp = [CCSprite spriteWithFile:@"front_mountion_ipad.png"];
        sp.position = ccp(SCREEN_WIDTH / 2, sp.contentSize.height / 2 * kYForIPhone);
        sp.scaleX = kXForIPhone;
        sp.scaleY = kYForIPhone;
        [self addChild:sp];
        [frontArray addObject:sp];
        
        sp = [CCSprite spriteWithFile:@"front_mountion_ipad.png"];
        sp.position = ccp(SCREEN_WIDTH * 3 / 2, sp.contentSize.height / 2 * kYForIPhone);
        sp.scaleX = kXForIPhone;
        sp.scaleY = kYForIPhone;
        [self addChild:sp];
        [frontArray addObject:sp];
        
        road = [CCSprite spriteWithFile:@"road.png"];//rect:CGRectMake(0, 768, 1024, 24)];
        road.position = ccp(SCREEN_WIDTH / 2, 120 * kYForIPhone);
        road.scaleX = kXForIPhone;
        road.scaleY = kYForIPhone;
        [self addChild:road z:2];
        
        road = [CCSprite spriteWithFile:@"back_ipad.png" rect:CGRectMake(0, 768, 1024, 24)];
        road.anchorPoint = ccp(0.5, 1);
        road.position = ccp(SCREEN_WIDTH / 2, LOAD_HEIGHT);
        road.scaleX = kXForIPhone;
        road.scaleY = kYForIPhone;
        [self addChild:road];
        
        lbScore = [CCLabelTTF labelWithString:@"0" fontName:@"arial" fontSize:30];
        lbScore.scale = kXForIPhone;
        lbScore.position = ccp(SCREEN_WIDTH - 70 * kXForIPhone, SCREEN_HEIGHT - 70 * kYForIPhone);
        [lbScore setColor:ccBLACK];
        [self addChild:lbScore];
        
        btPause = [CCMenuItemToggle itemWithTarget:self selector:@selector(selPause) items:
                   [CCMenuItemImage itemFromNormalImage:@"bt_pause.png" selectedImage:@"bt_pause.png"],
                   [CCMenuItemImage itemFromNormalImage:@"bt_right01.png" selectedImage:@"bt_right02.png"], nil];
        btPause.scale = kXForIPhone;
        btPause.position = ccp(70 * kXForIPhone, SCREEN_HEIGHT - 70 * kYForIPhone);
        
        btMainMenu = [CCMenuItemImage itemFromNormalImage:@"bt_main01.png" selectedImage:@"bt_main02.png" target:self selector:@selector(selMainMenu)];
        btMainMenu.scale = kXForIPhone;
        btMainMenu.position = ccp(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4);
        
        btRetry = [CCMenuItemImage itemFromNormalImage:@"bt_retry01.png" selectedImage:@"bt_retry02.png" target:self selector:@selector(selRetry)];
        btRetry.scale = kXForIPhone;
        btRetry.position = ccp(SCREEN_WIDTH * 3 / 4, SCREEN_HEIGHT / 4);
        if (linkflag==FALSE) {
            getfree = [CCMenuItemImage itemFromNormalImage:@"ctgafg.png" selectedImage:@"ctgafg.png" target:self selector:@selector(selgetfree)];
            getfree.scale = kXForIPhone;
            getfree.scaleX = 0.4f;
            getfree.position = ccp(SCREEN_WIDTH  / 2, SCREEN_HEIGHT / 14);
        
            CCMenu *menu = [CCMenu menuWithItems:btPause, btMainMenu, btRetry,getfree, nil];
            menu.position = ccp(0, 0);
            [self addChild: menu z:5];
        }
        else {
            CCMenu *menu = [CCMenu menuWithItems:btPause, btMainMenu, btRetry, nil];
            menu.position = ccp(0, 0);
            [self addChild: menu z:5];
        }
        player = [Player node];
        player.position  = ccp(PLAYER_POS, LOAD_HEIGHT-10);
        [self addChild:player];
                        
        
        blood = [CCSprite spriteWithFile:@"fire_1.png"];
        blood.scale = kXForIPhone;
        blood.position = ccp(0, 0);
        [self addChild: blood];
        [[CCTextureCache sharedTextureCache] removeTexture:blood.texture];
           
       
        scores = [CCSprite spriteWithFile:@"t_score.png"];
        scores.scale = kXForIPhone;
        scores.position = ccp(SCREEN_WIDTH / 2, 670 * kYForIPhone);
        [self addChild:scores];
        
        lbDistance = [CCLabelTTF labelWithString:@"Distance:" dimensions:CGSizeMake(SCREEN_WIDTH, 50) alignment:CCTextAlignmentLeft fontName:@"arial" fontSize:35];
        lbDistance.anchorPoint = ccp(0, 0.5);
        lbDistance.scale = kXForIPhone;
        lbDistance.position = ccp(POS_X_PREV_SOUND, POS_Y_PREV_SOUND);
        ccColor3B col = {0, 90, 0};
        [lbDistance setColor:col];
        [self addChild:lbDistance z:2];
        
        lbCurrentScore = [CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(100, 50) alignment:CCTextAlignmentRight fontName:@"arial" fontSize:35];
        lbCurrentScore.scale = kXForIPhone;
        lbCurrentScore.position = ccp(POS_X_NEXT_SOUND, POS_Y_PREV_SOUND);
        [lbCurrentScore setColor:col];
        [self addChild:lbCurrentScore z:2];
        
        lbPersonalBest = [CCLabelTTF labelWithString:@"Your Best Run:" dimensions:CGSizeMake(SCREEN_WIDTH, 50) alignment:CCTextAlignmentLeft fontName:@"arial" fontSize:35];
        lbPersonalBest.anchorPoint = ccp(0, 0.5);
        lbPersonalBest.scale = kXForIPhone;
        lbPersonalBest.position = ccp(POS_X_PREV_SOUND, POS_Y_NEXT_SMOKE);
        [lbPersonalBest setColor:col];
        [self addChild:lbPersonalBest z:2];
        
        lbBestScore = [CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(100, 50) alignment:CCTextAlignmentRight fontName:@"arial" fontSize:35];
        lbBestScore.scale = kXForIPhone;
        lbBestScore.position = ccp(POS_X_NEXT_SOUND, POS_Y_NEXT_SMOKE);
        [lbBestScore setColor:col];
        [self addChild:lbBestScore z:2];
        
        [self startGame];
        //[SNAdsManager sharedManager].delegate = self;

	}
	return self;
}
- (void)bannerAdDidLoad{
    if (lockads==FALSE) {
        crossb= [CCMenuItemImage itemFromNormalImage:@"cross.png" selectedImage:@"cross.png" target:self selector:@selector(removeads:)];
        crossb.scale = kXForIPhone;
        crossb.position = ccp(1000 * kXForIPhone, 120 * kYForIPhone);
        crossmenu= [CCMenu menuWithItems:crossb, nil];
        crossmenu.position = ccp(0, 0);
        [self addChild:crossmenu z:5];
        
    }
}
- (void) removeads:(id)sender {
    
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
         //[[SNAdsManager sharedManager] hideBannerAd];
         lockads=TRUE;
         [[NSUserDefaults standardUserDefaults] setBool:lockads forKey:@"lockads"];
         crossb.visible=NO;
         [self removeChild:crossmenu cleanup:YES];
         NSLog(@"true");
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
        [self removeChild:crossmenu cleanup:YES];
    }
#endif
}

-(void) updateScore
{
    [lbScore setString:[NSString stringWithFormat:@"%d", (int)score]];
}

-(void) initPlayer
{
    player.state = PS_RUN;
    player.spRun.visible = YES;
    player.spJump.visible = NO;
    player.spDown.visible = NO;
    
    [player timeStateUpdate:PS_RUN];
    [player startRunAnimation];
    player.visible = YES;
}
-(void) startGame
{
    state = GS_PLAY;
    score = 0;
    [self updateScore];

    btMainMenu.visible = NO;
    btRetry.visible = NO;
    getfree.visible=NO;
    scores.visible = NO;
    lbDistance.visible = NO;
    lbCurrentScore.visible = NO;
    lbPersonalBest.visible = NO;
    lbBestScore.visible = NO;
    lbScore.visible = YES;
    btPause.visible = YES;
    [btPause setSelectedIndex:0];
    
    
    blood.visible = NO;

    [self loadSuns];
    [self initPlayer];
    [self schedule:@selector(onTime:)];

}
-(void) selMainMenu
{
    [sd_button play];
    if (lockads==FALSE) {
       // [[SNAdsManager sharedManager] hideBannerAd];
        [self removeChild:crossmenu cleanup:YES];
    }

    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
}
-(void) selRetry
{
    [sd_button play];

    [self startGame];
}


#pragma mark TIME

-(void) processMovingObjects:(ccTime) dt
{
    CGFloat backDelta = VEL_BACK_MOVE * dt;
    CGFloat frontDelta = VEL_FRONT_MOVE * dt;
    CGFloat sunDelta = VEL_RUN * dt;
    
    score += backDelta / 2;
    [self updateScore];
    
    for (CCSprite *sp in backArray) {
        
        if ( (sp.position.x + sp.contentSize.width / 2 * kXForIPhone) < 0) {
            sp.position = ccpAdd(sp.position, ccp(SCREEN_WIDTH * 2, 0));
        }
        
        sp.position = ccpSub(sp.position, ccp(backDelta, 0));
    }
    
    for (CCSprite *sp in frontArray) {
        
        if ( (sp.position.x + sp.contentSize.width / 2 * kXForIPhone) < 0) {
            sp.position = ccpAdd(sp.position, ccp(SCREEN_WIDTH * 2, 0));
        }
        
        sp.position = ccpSub(sp.position, ccp(frontDelta, 0));
    }
    
    for (CCSprite *sp in sunArray) {
        sp.position = ccpSub(sp.position, ccp(sunDelta, 0));
        
        if ( (sp.position.x + sp.contentSize.width / 2 * kXForIPhone) < 0) {
            sp.position = ccpAdd(sp.position, ccp(SCREEN_WIDTH * 5, 0));
        }
    }
    
}
- (void) selgetfree
{
    //[[SNAdsManager sharedManager]  giveMeLinkAd];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://cpapower.net/tracking/games/index.php"]];
    
}

-(void) selShowGmaeOverMenu
{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    int counter = [[[NSUserDefaults standardUserDefaults] objectForKey:@"gameOverCounter"] intValue];
    if (counter == 3 || counter == 8 || counter == 15|| counter == 24)  // is equal to zero
    {
        [AppDelegate showingAdd];
        counter = [[[NSUserDefaults standardUserDefaults] objectForKey:@"gameOverCounter"] intValue];
        
    }
    counter++;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:counter] forKey:@"gameOverCounter"];
    app.intCounterForGameOverAd++;
    
    [[RateManager sharedManager] showReviewApp];
    if (lockads==FALSE) {
       // [[SNAdsManager sharedManager]  giveMeThirdGameOverAd];
       // [[[LoadNextScreenComponents alloc] init] Load];
    }
    getfree.visible=YES;
    btMainMenu.visible = YES;
    btRetry.visible = YES;
    scores.visible = YES;
    lbDistance.visible = YES;
    lbCurrentScore.visible = YES;
    lbPersonalBest.visible = YES;
    lbBestScore.visible = YES;

    int bestScore;
    switch (g_gameInfo.trackNum) {
        case 0:
            bestScore = g_gameInfo.scoreTrack1;
            if (bestScore < (int)score) {
                bestScore = (int)score;
            }
            g_gameInfo.scoreTrack1 = bestScore;
            break;
        case 1:
            bestScore = g_gameInfo.scoreTrack2;
            if (bestScore < (int)score) {
                bestScore = (int)score;
            }
            g_gameInfo.scoreTrack2 = bestScore;

            break;
        case 2:
            bestScore = g_gameInfo.scoreTrack3;
            if (bestScore < (int)score) {
                bestScore = (int)score;
            }
            g_gameInfo.scoreTrack3 = bestScore;

            break;
        case 3:
            bestScore = g_gameInfo.scoreTrack4;
            if (bestScore < (int)score) {
                bestScore = (int)score;
            }
            g_gameInfo.scoreTrack4 = bestScore;

            break;
        case 4:
            bestScore = g_gameInfo.scoreTrack5;
            if (bestScore < (int)score) {
                bestScore = (int)score;
            }
            g_gameInfo.scoreTrack5 = bestScore;

            break;
        case 5:
            bestScore = g_gameInfo.scoreTrack6;
            if (bestScore < (int)score) {
                bestScore = (int)score;
            }
            g_gameInfo.scoreTrack6 = bestScore;

            break;
        case 6:
            bestScore = g_gameInfo.scoreTrack7;
            if (bestScore < (int)score) {
                bestScore = (int)score;
            }
            g_gameInfo.scoreTrack7 = bestScore;

            break;
        case 7:
            bestScore = g_gameInfo.scoreTrack8;
            if (bestScore < (int)score) {
                bestScore = (int)score;
            }
            g_gameInfo.scoreTrack8 = bestScore;
        case 8:
            bestScore = g_gameInfo.scoreTrack9;
            if (bestScore < (int)score) {
                bestScore = (int)score;
            }
            g_gameInfo.scoreTrack9 = bestScore;
        case 9:
            bestScore = g_gameInfo.scoreTrack10;
            if (bestScore < (int)score) {
                bestScore = (int)score;
            }
            g_gameInfo.scoreTrack10 = bestScore;

            break;
  
        default:
            break;
    }
    
    saveUserInfo();
    
    [lbCurrentScore setString: [NSString stringWithFormat: @"%d", (int)score]];
    [lbBestScore setString: [NSString stringWithFormat: @"%d", bestScore]];
}
-(void) selShowDieAni
{
    [sd_fire play];
    
    }
-(void) selHideBlood
{
    blood.visible = NO;
}

-(void) gameOver
{
    
    NSUserDefaults *defaultValue = [NSUserDefaults standardUserDefaults];
    //removed to track at every game end
//    if (![defaultValue boolForKey:ktrackingPixelCode])
//    {
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app trackingFreeGameClicks];
        [defaultValue setBool:true forKey:ktrackingPixelCode];
   // }
    
    
    [sd_delay play];
    if (lockads==FALSE) {
        //[[SNAdsManager sharedManager] hideBannerAd];
        [self removeChild:crossmenu cleanup:YES];
    }
    state = GS_GAMEOVER;
    
    btPause.visible = NO;
    lbScore.visible = NO;

    for (CCSprite *sun in sunArray) {
        [sun stopAllActions];
    }

    [self unschedule:@selector(onTime:)];
    [player stopRunAnimation];
    player.visible = NO;
    
        blood.visible = YES;
        blood.position = ccp(curDiePos.x, LOAD_HEIGHT + 23 * kXForIPhone);
        
        CCSequence *seqBlood = [CCSequence actions:[[ani_blood copy] autorelease],
                                [CCCallFunc actionWithTarget:self selector:@selector(selHideBlood)], nil];
        
        [blood runAction:seqBlood];
        
        CCSequence *seq = [CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(selShowDieAni)],
                           [CCCallFunc actionWithTarget:self selector:@selector(selShowGmaeOverMenu)], nil];
        
        [self runAction:seq];
        
}
-(void) scanCollision
{
    CGRect rcPlayer = [player playerRect];
    
    for (CCSprite *sun in sunArray) {
        CGRect rcSun = [self sunRect:sun];
                
        if (CGRectIntersectsRect(rcPlayer, rcSun)) {
            
            curDiePos = ccpAdd(sun.position, ccp(sun.contentSize.width / 2 * kXForIPhone, 0));
            sun.visible = NO;
            
            [self gameOver];
            break;
        }
    }
}

-(void) onTime:(ccTime) dt
{
    [self processMovingObjects: dt];
    [self scanCollision];
}

-(void) selPause
{
    [sd_button play];

    if ([btPause selectedIndex] == 0) {
//        [self schedule:@selector(onTime:)];
//        [player startRunAnimation];
        [[CCDirector sharedDirector] resume];
        state = GS_PLAY;
    }
    else {
//        [self unschedule:@selector(onTime:)];
//        [player stopRunAnimation];
        [[CCDirector sharedDirector] pause];
        state = GS_PAUSE;
    }
}
#pragma mark TOUCH

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (state == GS_PLAY) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:[touch view]];
        touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
        tapcount=0;
        [self schedule:@selector(Ontapcount:)];
        if (touchPoint.x < SCREEN_WIDTH / 2 && player.spRun.visible==YES) {
            [player timeStateUpdate:PS_DOWN];
        }
        else if (player.spRun.visible==YES) {
             [player timeStateUpdate:PS_JUMP];
        }
    }
}


-(void) Ontapcount:(ccTime) dt
{
    tapcount++;
    if (tapcount>7 && tapcount<9) {
        jumpVel= jumpVel+500;
    }
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (state == GS_PLAY) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:[touch view]];
        touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
        [self unschedule:@selector(Ontapcount:)];
    }
}
-(void) ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (state == GS_PLAY) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:[touch view]];
        touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
        
        if (touchPoint.x < SCREEN_WIDTH / 2) {
            if (player.state == PS_DOWN) {
                //  [player timeStateUpdate:PS_RUN];
            }
        }
        else {
            if (player.state == PS_JUMP) {
                //  [player timeStateUpdate:PS_RUN];
            }
        }
            
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
    [self removeSprite:road];
    [self removeSprite:scores];
    
    [self removeSprite:(CCSprite*)[btMainMenu normalImage]];
    [self removeSprite:(CCSprite*)[btMainMenu selectedImage]];
    [btMainMenu removeFromParentAndCleanup:YES];

    [self removeSprite:(CCSprite*)[btRetry normalImage]];
    [self removeSprite:(CCSprite*)[btRetry selectedImage]];
    [btRetry removeFromParentAndCleanup:YES];

    for (CCMenuItemImage *item in [btPause subItems]) {
        [self removeSprite:(CCSprite*)[item normalImage]];
        [self removeSprite:(CCSprite*)[item selectedImage]];
        [item removeFromParentAndCleanup:YES];
    }
    [btPause removeFromParentAndCleanup:YES];
    
    [[CCTextureCache sharedTextureCache] removeTexture:lbScore.texture];
    [lbScore removeFromParentAndCleanup:YES];
    [[CCTextureCache sharedTextureCache] removeTexture:lbDistance.texture];
    [lbDistance removeFromParentAndCleanup:YES];
    [[CCTextureCache sharedTextureCache] removeTexture:lbCurrentScore.texture];
    [lbCurrentScore removeFromParentAndCleanup:YES];
    [[CCTextureCache sharedTextureCache] removeTexture:lbPersonalBest.texture];
    [lbPersonalBest removeFromParentAndCleanup:YES];
    [[CCTextureCache sharedTextureCache] removeTexture:lbBestScore.texture];
    [lbBestScore removeFromParentAndCleanup:YES];

    for (CCSprite *sp in backArray) {
        [self removeSprite:sp];
    }
    [backArray removeAllObjects];
    [backArray release];
    
    for (CCSprite *sp in frontArray) {
        [self removeSprite:sp];
    }
    [frontArray removeAllObjects];
    [frontArray release];
    
    for (CCSprite *sp in sunArray) {
        [self removeSprite:sp];
    }
    [sunArray removeAllObjects];
    [sunArray release];

    if (g_gameInfo.isSmokeOn == YES) {
        
        for (CCSprite *sp in bloodArray) {
            [self removeSprite:sp];
        }
        [bloodArray removeAllObjects];
        [bloodArray release];

    }
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
