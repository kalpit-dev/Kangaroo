//
//  Menu.h
//  Line Runner!
//
//  Created by Yang yang on 1/29/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Options;
@class Tutorial;
@class Play;

@interface Menu : CCLayer {
    CCMenuItemImage *btOptions;
    CCMenuItemImage *btTutorial;
    CCMenuItemImage *btPlay;
    CCMenuItemImage *btFaceBook;
    CCMenuItemImage *btTwitter;
    CCMenuItemImage *morescreen;
    CCMenu *update_restore;
    CCSprite *road;
    Options *optionsLayer;
    Tutorial *tutorialLayer;
    Play *playLayer;
    
    CCSprite *text01;
    CCSprite *text02;
}

-(void) showButtons;
-(void) hideButtons;

@end
