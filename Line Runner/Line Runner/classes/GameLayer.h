//
//  GameLayer.h
//  Line Runner!
//
//  Created by Yang yang on 1/30/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AppDelegate.h"
#import "AppTracker.h"
//#import "SNAdsManager.h"

@class Player;
extern BOOL lockads;
extern BOOL linkflag;
extern CGFloat jumpVel;
enum GAME_STATE {
    GS_PLAY = 0,
    GS_PAUSE = 1,
    GS_GAMEOVER = 2
    };

@interface GameLayer : CCLayer /*<SNAdsManagerDelegate>*/{
    CCSprite *background;
    CCSprite *road;
    
    NSMutableArray *backArray;
    NSMutableArray *frontArray;
    
    NSMutableArray *sunArray;
    NSMutableArray *bloodArray;
    
    CCSprite *blood;
    
    CCLabelTTF *lbScore;
    CCMenuItemToggle *btPause;
    CCMenuItemImage *btMainMenu;
    CCMenuItemImage *btRetry;
    CCMenuItemImage *getfree;
    CCMenuItemImage *crossb;
    CCMenu *crossmenu;

    Player *player;
    
    CGFloat score;
    CCSprite *scores;
    CCLabelTTF *lbDistance;
    CCLabelTTF *lbCurrentScore;
    CCLabelTTF *lbPersonalBest;
    CCLabelTTF *lbBestScore;
    
    enum GAME_STATE state;
}

-(void) startGame;
-(void)removeSprite:(CCSprite*)sp;

@end
