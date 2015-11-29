//
//  Player.m
//  Line Runner!
//
//  Created by Yang yang on 1/30/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import "Player.h"
#import "Setting.h"

ccTime jumpTimeCounter;
ccTime downTimeCounter;
extern int tapcount;
@implementation Player

@synthesize spRun;
@synthesize spDown;
@synthesize spJump;
@synthesize state;

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        self.anchorPoint = ccp(0, 0);
        self.scale = kXForIPhone;
        
        if (chracter==1) {
            spRun = [CCSprite spriteWithFile:@"bluehero_run_01.png"];
            spJump = [CCSprite spriteWithFile:@"bluehero_jump_01.png"];
            spDown = [CCSprite spriteWithFile:@"bluehero_duck_01.png"];
        }
        else if (chracter==2) {
            spRun = [CCSprite spriteWithFile:@"redhero_run_01.png"];
            spJump = [CCSprite spriteWithFile:@"redhero_jump_01.png"];
            spDown = [CCSprite spriteWithFile:@"redhero_duck_01.png"];
        }
        else if (chracter==3) {
            spRun = [CCSprite spriteWithFile:@"yellowhero_run_01.png"];
            spJump = [CCSprite spriteWithFile:@"yellowhero_jump_01.png"];
            spDown = [CCSprite spriteWithFile:@"yellowhero_duck_01.png"];
        }
        else if (chracter==4) {
            spRun = [CCSprite spriteWithFile:@"BlueHero_moto_run_1.png"];
            spJump = [CCSprite spriteWithFile:@"BlueHero_moto_jump_1.png"];
            spDown = [CCSprite spriteWithFile:@"BlueHero_moto_duck_1.png"];
        }
        else if (chracter==5) {
            spRun = [CCSprite spriteWithFile:@"RedHero_moto_run_1.png"];
            spJump = [CCSprite spriteWithFile:@"RedHero_moto_jump_1.png"];
            spDown = [CCSprite spriteWithFile:@"RedHero_moto_duck_1.png"];
        }
        else if (chracter==6) {
            spRun = [CCSprite spriteWithFile:@"YellowHero_moto_run_1.png"];
            spJump = [CCSprite spriteWithFile:@"YellowHero_moto_jump_1.png"];
            spDown = [CCSprite spriteWithFile:@"YellowHero_moto_duck_1.png"];
        }
        
        spRun.anchorPoint = ccp(0, 0);
        spRun.position = ccp(0, 0);
        spRun.scale = 0.7;
        [self addChild:spRun];
        [[CCTextureCache sharedTextureCache] removeTexture: spRun.texture];
        
        spJump.anchorPoint = ccp(0, 0);
        spJump.position = ccp(0, 0);
        spJump.scale = 0.7;
        spJump.visible = NO;
        [self addChild:spJump];
        [[CCTextureCache sharedTextureCache] removeTexture: spJump.texture];
        
        spDown.anchorPoint = ccp(0, 0);
        spDown.position = ccp(0, 0);
        spDown.scale = 0.7;
        spDown.visible = NO;
        [self addChild:spDown];
        [[CCTextureCache sharedTextureCache] removeTexture: spDown.texture];
    }
    return self;
}

-(CGRect) playerRect
{
    CGRect rt = CGRectZero;
    CGSize sz = CGSizeZero;
    switch (state) {
        case PS_RUN:
            sz = CGSizeMake(spRun.contentSize.width * kXForIPhone * 0.5,
                            spRun.contentSize.height * kXForIPhone);
            rt = CGRectMake(self.position.x, self.position.y,
                            sz.width, sz.height);
            break;
        case PS_JUMP:
            
            sz = CGSizeMake(spJump.contentSize.width * kXForIPhone * 0.5,
                            spJump.contentSize.height * kXForIPhone);
            rt = CGRectMake(self.position.x, self.position.y + spJump.position.y * kXForIPhone,
                            sz.width-10, sz.height+20);
            break;
        case PS_DOWN:
            
            sz = CGSizeMake(spDown.contentSize.width * kXForIPhone * 0.5,
                            spDown.contentSize.height * kXForIPhone);
            rt = CGRectMake(self.position.x, self.position.y,
                            sz.width, sz.height-20);
            break;
            
        default:
            break;
    }
    return rt;
}

- (void)stopRunAnimation {
    [spRun stopAllActions];
    [spJump stopAllActions];
    [spDown stopAllActions];
}

-(void) startRunAnimation
{
    [spRun runAction:[CCRepeatForever actionWithAction:[[ani_run copy] autorelease]]];
}

- (void) startjumpanimation
{
    [spJump runAction:[CCRepeatForever actionWithAction:[[ani_jump copy] autorelease]]];
}

- (void)startdiveanimation1
{
    [spDown runAction:[CCRepeatForever actionWithAction:[[ani_dive1 copy] autorelease]]];
}

- (void)startdiveanimation2
{
    [spDown runAction:[CCRepeatForever actionWithAction:[[ani_dive2 copy] autorelease]]];
}

#pragma mark TIME

-(void) onTimeDown:(ccTime) dt
{
    if (spJump.position.y != 0) {
        return;
    }
    
    state = PS_DOWN;
    spRun.visible = NO;
    spJump.visible = NO;
    spDown.visible = YES;
    downTimeCounter += dt;
    if (tapcount<8) {
        if (downTimeCounter > 0.8) {
            downTimeCounter = 0.0;
            
            state = PS_RUN;
            spRun.visible = YES;
            spJump.visible = NO;
            spDown.visible = NO;
            [self timeStateUpdate:PS_RUN];
            [self unschedule:@selector(onTimeDown:)];
        }
    }
    else {
        if (downTimeCounter > 1.0) {
            downTimeCounter = 0.0;
            
            state = PS_RUN;
            spRun.visible = YES;
            spJump.visible = NO;
            spDown.visible = NO;
            [self timeStateUpdate:PS_RUN];
            [self unschedule:@selector(onTimeDown:)];
        }
    }
    
}
-(void) onTimeJump:(ccTime) dt
{
//    jumpTimeCounter += dt;
//
//    if (jumpTimeCounter > 0.5) {
//        
//        if (spJump.position. y > 0) {
//            spJump.position = ccpSub(spJump.position, ccp(0, VEL_JUMP * dt));
//        }
//        else {
//            jumpTimeCounter = 0.0;
//            [self unschedule:@selector(onTimeJump:)];
//            spJump.position = ccp(0, 0);
//            [self timeStateUpdate:PS_RUN];
//
//        }
//    }
//    else {
//        if (spJump.position.y < DELTA_HEIGHT / kYForIPhone * 2) {
//            spJump.position = ccpAdd(spJump.position, ccp(0, VEL_JUMP * dt));
//        }
//        else if (spJump.position.y > DELTA_HEIGHT / kYForIPhone * 2) {
//            spJump.position = ccp(0, DELTA_HEIGHT / kYForIPhone * 2);
//        }
//
//    }
    
    
    jumpVel += ACEL_GRAVITY * dt;
    spJump.position = ccpAdd(spJump.position, ccp(0, jumpVel * dt+5));
    
    if (spJump.position.y < 0) {
        jumpTimeCounter = 0.0;
        
        spJump.position = ccp(0, 0);
        
        state = PS_RUN;
        spRun.visible = YES;
        spJump.visible = NO;
        spDown.visible = NO;
        [self timeStateUpdate:PS_RUN];
        [self unschedule:@selector(onTimeJump:)];
    }
}
-(void) timeStateUpdate:(enum PLAYER_STATE) newState
{
    if (newState == PS_RUN) {
        if (downTimeCounter != 0.0) {
            downTimeCounter = 0.0;
            
            state = PS_RUN;
            spRun.visible = YES;
            spJump.visible = NO;
            spDown.visible = NO;
            //  [self startRunAnimation];
            //  [spDown stopAllActions];
            //   [spJump stopAllActions];
            [self unschedule:@selector(onTimeDown:)];
        }
        if (jumpTimeCounter != 0.0) {
            //            jumpTimeCounter = 0.0;
            //            spJump.position = ccp(0, 0);
            
            if (jumpVel > 0) {
                jumpVel = 0;
            }
            //            [self unschedule:@selector(onTimeJump:)];
        }
        
    }
    else {
        
        if (newState == PS_JUMP) {
            if (downTimeCounter != 0.0) {
                downTimeCounter = 0.0;
                [self unschedule:@selector(onTimeDown:)];
            }
            if (jumpTimeCounter != 0.0) {
                jumpTimeCounter = 0.0;
                spJump.position = ccp(0, 0);
                [self unschedule:@selector(onTimeJump:)];
            }
            
            state = PS_JUMP;
            spRun.visible = NO;
            spJump.visible = YES;
            spDown.visible = NO;
            
            jumpTimeCounter = 1.0;
//            if (tapcount<4) {
//                jumpVel = VEL_JUMP;
//            }
//            else {
//                jumpVel = 1650;
//            }
            jumpVel = VEL_JUMP;
            for (int i = 0; i < 3; i ++) {
                if (![sd_jump[i] isPlaying]) {
                    [sd_jump[i] play];
                    break;
                }
            }
            [self startjumpanimation];
            //   [spRun stopAllActions];
            //   [spDown stopAllActions];
            [self schedule:@selector(onTimeJump:)];
        }
        if (newState == PS_DOWN) {
            if (downTimeCounter != 0.0) {
                downTimeCounter = 0.0;
                [self unschedule:@selector(onTimeDown:)];
            }
            if (jumpTimeCounter != 0.0) {
                //                jumpTimeCounter = 0.0;
                //                spJump.position = ccp(0, 0);
                //                [self unschedule:@selector(onTimeJump:)];
                if (jumpVel > 0) {
                    jumpVel = 0;
                }
                
            }
            if (tapcount<8 ) {
                [self startdiveanimation1];
            }
            else {
                [self startdiveanimation2];
            }
            
            //  [spRun stopAllActions];
            // [spJump stopAllActions];
            downTimeCounter = 0.0;
            [self schedule:@selector(onTimeDown:)];
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
    [self removeSprite:spRun];
    [self removeSprite:spJump];
    [self removeSprite:spDown];
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
