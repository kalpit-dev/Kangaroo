//
//  Tutorial.h
//  Line Runner!
//
//  Created by Yang yang on 1/29/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Menu;

@interface Tutorial : CCLayer {
    Menu *parentMenu;

    CCSprite *tutorial;
    
    CCMenuItemImage *btBack;
}

@property (nonatomic, retain) Menu *parentMenu;

-(void) showButtons;
-(void) hideButtons;

@end
