//
//  Play.h
//  Line Runner!
//
//  Created by Yang yang on 1/29/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Menu;
extern int chracter;
@interface Play : CCLayer {
    Menu *parentMenu;

    CCSprite *selectTrack;
    CCMenuItemImage *btprevSound;
    CCMenuItemImage *btnextSound;
    CCLabelTTF *lbTrack;
    
    CCMenuItemImage *btprevSmoke;
    CCMenuItemImage *btnextSmoke;
    CCLabelTTF *lbSmoke;
    
    CCMenuItemImage *btPlay;
    CCMenuItemImage *btGetIt;

}

@property (nonatomic, retain) Menu *parentMenu;

-(void) showButtons;
-(void) hideButtons;
-(void) updateTrack;
-(void) updateBlood;

-(void) setEnableMenuItems:(BOOL) flag;
-(void) updateInAppResult;

@end
