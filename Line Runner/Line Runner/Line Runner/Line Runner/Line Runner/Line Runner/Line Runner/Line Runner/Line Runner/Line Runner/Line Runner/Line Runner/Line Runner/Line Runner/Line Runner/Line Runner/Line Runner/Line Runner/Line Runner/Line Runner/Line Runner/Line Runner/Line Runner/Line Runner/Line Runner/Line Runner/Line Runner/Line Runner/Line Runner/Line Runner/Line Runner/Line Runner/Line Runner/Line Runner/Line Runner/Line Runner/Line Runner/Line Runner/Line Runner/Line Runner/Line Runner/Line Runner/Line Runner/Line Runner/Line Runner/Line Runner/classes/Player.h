//
//  Player.h
//  Line Runner!
//
//  Created by Yang yang on 1/30/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

extern int chracter;
CGFloat jumpVel;
enum PLAYER_STATE {
    PS_RUN = 0,
    PS_JUMP = 1,
    PS_DOWN = 2
    };

@interface Player : CCSprite {
    enum PLAYER_STATE state;
    
    CCSprite *spRun;
    CCSprite *spJump;
    CCSprite *spDown;
    
    
}

@property (nonatomic) enum PLAYER_STATE state;
@property (nonatomic, retain) CCSprite *spRun;
@property (nonatomic, retain) CCSprite *spJump;
@property (nonatomic, retain) CCSprite *spDown;

-(void) timeStateUpdate:(enum PLAYER_STATE) newState;
-(CGRect) playerRect;

-(void) startRunAnimation;
-(void) stopRunAnimation;

@end
