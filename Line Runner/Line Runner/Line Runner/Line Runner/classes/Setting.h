//
//  Setting.h
//  Line Runner!
//
//  Created by Yang yang on 1/29/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Play.h"


#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#define VEL_BACK_MOVE   (50 * kXForIPhone)
#define VEL_FRONT_MOVE  (150 * kXForIPhone)
#define VEL_RUN         (750 * kXForIPhone)
//#define VEL_JUMP        (1100 * kYForIPhone)
//#define ACEL_GRAVITY    (-4000 * kYForIPhone)
#define VEL_JUMP        (1250)
#define ACEL_GRAVITY    (-5000)


#define TRACK_COUNT 10

#define FLOOR_HEIGHT (185 * kYForIPhone)
#define DELTA_HEIGHT (180 * kYForIPhone)

#define LOAD_HEIGHT (243 * kYForIPhone)
#define PLAYER_POS  (120 * kXForIPhone)


// GAME INFO

struct GAMEINFO {
    BOOL isSoundOn;
    BOOL isGraveOn;
    BOOL isSmokeOn;
    BOOL isGetBloodINAPP;
    
    int scoreTrack1;
    int scoreTrack2;
    int scoreTrack3;
    int scoreTrack4;
    int scoreTrack5;
    int scoreTrack6;
    int scoreTrack7;
    int scoreTrack8;
    int scoreTrack9;
    int scoreTrack10;
    
    int trackNum;
};

extern struct GAMEINFO g_gameInfo;


//SCALE
extern float kXForIPhone;
extern float kYForIPhone;

extern float SCREEN_HEIGHT;
extern float SCREEN_WIDTH;

// ANIMATION

extern CCAction *ani_run;
extern CCAction *ani_sun;
extern CCAction *ani_blood;
extern CCAction *ani_jump;
extern CCAction *ani_dive1;
extern CCAction *ani_dive2;

// SOUNDS

extern AVAudioPlayer *sd_menuback;
extern AVAudioPlayer *sd_jump[3];
extern AVAudioPlayer *sd_button;
extern AVAudioPlayer *sd_delay;
extern AVAudioPlayer *sd_fire;
extern int chracter;
// Functions

BOOL game_initialize();
BOOL game_release();
BOOL allSoundPause();
void saveUserInfo();


