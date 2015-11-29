//
//  HelloWorldLayer.h
//  Line Runner
//
//  Created by Yang yang on 1/28/12.
//  Copyright physicsgametop 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Setting.h"

@class Menu;

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer<AVAudioPlayerDelegate>
{
    CCSprite *background;
    
    Menu *menuLayer;
    NSMutableArray *backArray;
    NSMutableArray *frontArray;
    
    NSMutableArray *sunArray;
}
//returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
