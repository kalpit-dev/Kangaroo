//
//  Options.h
//  Line Runner!
//
//  Created by Yang yang on 1/29/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Menu;

@interface Options : CCLayer {
    Menu *parentMenu;
    
    CCSprite *options;
    CCMenuItemImage *btprevSound;
    CCMenuItemImage *btnextSound;
    CCLabelTTF *lbSound;

    CCMenuItemImage *btBack;
}

@property (nonatomic, retain) Menu *parentMenu;

-(void) showButtons;
-(void) hideButtons;
-(void) updateSoundLabel;

@end
