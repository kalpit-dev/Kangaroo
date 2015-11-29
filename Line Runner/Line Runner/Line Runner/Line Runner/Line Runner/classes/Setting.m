//
//  Setting.m
//  Line Runner!
//
//  Created by Yang yang on 1/29/12.
//  Copyright 2012 physicsgametop. All rights reserved.
//

#import "Setting.h"

struct GAMEINFO g_gameInfo;

// IN app

Play* InAppParent_CoinShop = nil;

// Scale

float kXForIPhone = 1;
float kYForIPhone = 1;

float SCREEN_WIDTH = 320;
float SCREEN_HEIGHT = 480;

// ANIMATION

CCAction *ani_run = nil;
CCAction *ani_jump = nil;
CCAction *ani_dive1 = nil;
CCAction *ani_dive2 = nil;
CCAction *ani_sun = nil;
CCAction *ani_smoke = nil;
CCAction *ani_blood = nil;

// SOUNDS

AVAudioPlayer *sd_menuback = nil;
AVAudioPlayer *sd_jump[3];
AVAudioPlayer *sd_button = nil;
AVAudioPlayer *sd_delay = nil;
AVAudioPlayer *sd_fire = nil;

// FILES

NSString *IMG_RUNb[] ={
    @"bluehero_run_01.png",
    @"bluehero_run_02.png",
    @"bluehero_run_03.png",
    @"bluehero_run_04.png",
    @"bluehero_run_05.png",
    @"bluehero_run_06.png",
  //  nil
};

NSString *IMG_JUMPb[] ={
    @"bluehero_jump_01.png",
    @"bluehero_jump_02.png",
    @"bluehero_jump_03.png",
    @"bluehero_jump_04.png",
    @"bluehero_jump_05.png",
    @"bluehero_jump_06.png",
    @"bluehero_jump_07.png",
  //  nil
};

NSString *IMG_DIVEb[] ={
    @"bluehero_duck_01.png",
    @"bluehero_duck_02.png",
    @"bluehero_duck_03.png",
    @"bluehero_duck_04.png",
    @"bluehero_duck_05.png",
    @"bluehero_duck_06.png",
    @"bluehero_duck_07.png",
  //  nil
};

NSString *IMG_RUNbb[] ={
    @"BlueHero_moto_run_1.png",
    @"BlueHero_moto_run_2.png",
    @"BlueHero_moto_run_3.png",
    @"BlueHero_moto_run_4.png",
    @"BlueHero_moto_run_5.png",
    @"BlueHero_moto_run_6.png",
  //  nil
};

NSString *IMG_JUMPbb[] ={
    @"BlueHero_moto_jump_1.png",
    @"BlueHero_moto_jump_2.png",
    @"BlueHero_moto_jump_3.png",
    @"BlueHero_moto_jump_4.png",
    @"BlueHero_moto_jump_5.png",
    @"BlueHero_moto_jump_6.png",
    @"BlueHero_moto_jump_7.png",

  //  nil
};

NSString *IMG_DIVEbb[] ={
    @"BlueHero_moto_duck_1.png",
    @"BlueHero_moto_duck_2.png",
    @"BlueHero_moto_duck_3.png",
    @"BlueHero_moto_duck_4.png",
    @"BlueHero_moto_duck_5.png",
    @"BlueHero_moto_duck_6.png",
    @"BlueHero_moto_duck_7.png",
 //   nil
};

NSString *IMG_RUNr[] ={
    @"redhero_run_01.png",
    @"redhero_run_02.png",
    @"redhero_run_03.png",
    @"redhero_run_04.png",
    @"redhero_run_05.png",
    @"redhero_run_06.png",
    //   nil
};

NSString *IMG_JUMPr[] ={
    @"redhero_jump_01.png",
    @"redhero_jump_02.png",
    @"redhero_jump_03.png",
    @"redhero_jump_04.png",
    @"redhero_jump_05.png",
    @"redhero_jump_06.png",
    @"redhero_jump_07.png",

  //  nil
};

NSString *IMG_DIVEr[] ={
    @"redhero_duck_01.png",
    @"redhero_duck_02.png",
    @"redhero_duck_03.png",
    @"redhero_duck_04.png",
    @"redhero_duck_05.png",
    @"redhero_duck_06.png",
    @"redhero_duck_07.png",
  //  nil
};

NSString *IMG_RUNrb[] ={
    @"RedHero_moto_run_1.png",
    @"RedHero_moto_run_2.png",
    @"RedHero_moto_run_3.png",
    @"RedHero_moto_run_4.png",
    @"RedHero_moto_run_5.png",
    @"RedHero_moto_run_6.png",
    //  nil
};

NSString *IMG_JUMPrb[] ={
    @"RedHero_moto_jump_1.png",
    @"RedHero_moto_jump_2.png",
    @"RedHero_moto_jump_3.png",
    @"RedHero_moto_jump_4.png",
    @"RedHero_moto_jump_5.png",
    @"RedHero_moto_jump_6.png",
    @"RedHero_moto_jump_7.png",
  //  nil
};

NSString *IMG_DIVErb[] ={
    @"RedHero_moto_duck_1.png",
    @"RedHero_moto_duck_2.png",
    @"RedHero_moto_duck_3.png",
    @"RedHero_moto_duck_4.png",
    @"RedHero_moto_duck_5.png",
    @"RedHero_moto_duck_6.png",
    @"RedHero_moto_duck_7.png",
 //   nil
};

NSString *IMG_RUNy[] ={
    @"yellowhero_run_01.png",
    @"yellowhero_run_02.png",
    @"yellowhero_run_03.png",
    @"yellowhero_run_04.png",
    @"yellowhero_run_05.png",
    @"yellowhero_run_06.png",
 //   nil
};

NSString *IMG_JUMPy[] ={
    @"yellowhero_jump_01.png",
    @"yellowhero_jump_02.png",
    @"yellowhero_jump_03.png",
    @"yellowhero_jump_04.png",
    @"yellowhero_jump_05.png",
    @"yellowhero_jump_06.png",
    @"yellowhero_jump_07.png",

  //  nil
};

NSString *IMG_DIVEy[] ={
    @"yellowhero_duck_01.png",
    @"yellowhero_duck_02.png",
    @"yellowhero_duck_03.png",
    @"yellowhero_duck_04.png",
    @"yellowhero_duck_05.png",
    @"yellowhero_duck_06.png",
    @"yellowhero_duck_07.png",
 //    nil
};

NSString *IMG_RUNyb[] ={
    @"YellowHero_moto_run_1.png",
    @"YellowHero_moto_run_2.png",
    @"YellowHero_moto_run_3.png",
    @"YellowHero_moto_run_4.png",
    @"YellowHero_moto_run_5.png",
    @"YellowHero_moto_run_6.png",
  //  nil
};

NSString *IMG_JUMPyb[] ={
    @"YellowHero_moto_jump_1.png",
    @"YellowHero_moto_jump_2.png",
    @"YellowHero_moto_jump_3.png",
    @"YellowHero_moto_jump_4.png",
    @"YellowHero_moto_jump_5.png",
    @"YellowHero_moto_jump_6.png",
    @"YellowHero_moto_jump_7.png",

 //   nil
};

NSString *IMG_DIVEyb[] ={
    @"YellowHero_moto_duck_1.png",
    @"YellowHero_moto_duck_2.png",
    @"YellowHero_moto_duck_3.png",
    @"YellowHero_moto_duck_4.png",
    @"YellowHero_moto_duck_5.png",
    @"YellowHero_moto_duck_6.png",
    @"YellowHero_moto_duck_7.png",
 //   nil
};

NSString *IMG_SUN[] = {
    @"tred.png",
    @"tyellow.png",
    @"tgreen.png",
    nil
};

BOOL initAnimation()
{
    NSString *fileName;
    UIImage *image;	
    NSMutableArray *expArray0 = [NSMutableArray array];
    CCAnimation *animation;
    
    // Moto_N
    for (int num = 0; num<6; num ++) {
        if (chracter==1) {
            fileName = IMG_RUNb[num];
        }
        else if (chracter==2) {
            fileName = IMG_RUNr[num];
        }
        else if (chracter==3) {
            fileName = IMG_RUNy[num];
        }
        else if (chracter==4) {
            fileName = IMG_RUNbb[num];
        }
        else if (chracter==5) {
            fileName = IMG_RUNrb[num];
        }
        else if (chracter==6) {
            fileName = IMG_RUNyb[num];
        }
    	image = [UIImage imageNamed:fileName];
    	CCTexture2D *texture = [[CCTexture2D alloc] initWithImage:image];
    	
    	// manually add frames to the frame cache
    	CCSpriteFrame *frame0 = [CCSpriteFrame frameWithTexture:texture 
                                                             rect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];
    	[expArray0 addObject:frame0];
    	
    }
    animation = [CCAnimation animationWithFrames:expArray0 delay:0.09f];
    ani_run = [[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO] retain];
    [expArray0 removeAllObjects];
    
    for (int num = 0; num<7; num ++) {
        if (chracter==1) {
            fileName = IMG_JUMPb[num];
        }
        else if (chracter==2) {
            fileName = IMG_JUMPr[num];
        }
        else if (chracter==3) {
            fileName = IMG_JUMPy[num];
        }
        else if (chracter==4) {
            fileName = IMG_JUMPbb[num];
        }
        else if (chracter==5) {
            fileName = IMG_JUMPrb[num];
        }
        else if (chracter==6) {
            fileName = IMG_JUMPyb[num];
        }
        image = [UIImage imageNamed:fileName];
        CCTexture2D *texture = [[CCTexture2D alloc] initWithImage:image];
    	// manually add frames to the frame cache
    	CCSpriteFrame *frame0 = [CCSpriteFrame frameWithTexture:texture
                                                           rect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];
    	[expArray0 addObject:frame0];
    	
    }
    animation = [CCAnimation animationWithFrames:expArray0 delay:0.09f];
    ani_jump = [[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO] retain];
    [expArray0 removeAllObjects];
    
    for (int num = 0; num<7; num ++) {
        if (chracter==1) {
            fileName = IMG_DIVEb[num];
        }
        else if (chracter==2) {
            fileName = IMG_DIVEr[num];
        }
        else if (chracter==3) {
            fileName = IMG_DIVEy[num];
        }
        else if (chracter==4) {
            fileName = IMG_DIVEbb[num];
        }
        else if (chracter==5) {
            fileName = IMG_DIVErb[num];
        }
        else if (chracter==6) {
            fileName = IMG_DIVEyb[num];
        }
        image = [UIImage imageNamed:fileName];
        CCTexture2D *texture = [[CCTexture2D alloc] initWithImage:image];
    	// manually add frames to the frame cache
    	CCSpriteFrame *frame0 = [CCSpriteFrame frameWithTexture:texture
                                                           rect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];
    	[expArray0 addObject:frame0];
    	
    }
    animation = [CCAnimation animationWithFrames:expArray0 delay:0.09f];
    ani_dive1 = [[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO] retain];
    animation = [CCAnimation animationWithFrames:expArray0 delay:0.2f];
    ani_dive2 = [[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO] retain];
    [expArray0 removeAllObjects];
    
    for (int num = 0; IMG_SUN[num] != nil; num ++) {
    	fileName = IMG_SUN[num];
        image = [UIImage imageNamed:fileName];
        CCTexture2D *texture = [[CCTexture2D alloc] initWithImage:image];
    	// manually add frames to the frame cache
    	CCSpriteFrame *frame0 = [CCSpriteFrame frameWithTexture:texture 
                                                           rect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];
    	[expArray0 addObject:frame0];
    	
    }
    animation = [CCAnimation animationWithFrames:expArray0 delay:0.2f];
    ani_sun = [[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO] retain];
    [expArray0 removeAllObjects];

   
    for (int num = 1; num < 5; num ++) {
    	fileName = [NSString stringWithFormat: @"fire_%d.png", num];
        image = [UIImage imageNamed:fileName];
        CCTexture2D *texture = [[CCTexture2D alloc] initWithImage:image];
    	// manually add frames to the frame cache
    	CCSpriteFrame *frame0 = [CCSpriteFrame frameWithTexture:texture 
                                                           rect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];
    	[expArray0 addObject:frame0];
    	
    }
    animation = [CCAnimation animationWithFrames:expArray0 delay:0.09f];
    ani_blood = [[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO] retain];
    [expArray0 removeAllObjects];

    return TRUE;
}
BOOL loadSounds()
{
    NSError *error = nil; 
    NSURL *urlFileName;
      
    urlFileName = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"menuback" ofType:@"mp3"]];
    sd_menuback = [[AVAudioPlayer alloc] initWithContentsOfURL: urlFileName error:&error]; 
    
    urlFileName = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"button" ofType:@"aif"]];
    sd_button = [[AVAudioPlayer alloc] initWithContentsOfURL: urlFileName error:&error]; 

    urlFileName = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"char_deathMale1" ofType:@"caf"]];
    sd_delay = [[AVAudioPlayer alloc] initWithContentsOfURL: urlFileName error:&error]; 

    urlFileName = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Fire_Torch_Loop1" ofType:@"caf"]];
    sd_fire = [[AVAudioPlayer alloc] initWithContentsOfURL: urlFileName error:&error]; 

    for (int i = 0; i < 3; i ++) {
        urlFileName = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sg_rope" ofType:@"wav"]];
        sd_jump[i] = [[AVAudioPlayer alloc] initWithContentsOfURL: urlFileName error:&error]; 
    }

    return TRUE;
}
void loadUserInfo()
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *szFile = [documentsDirectory stringByAppendingPathComponent: @"Info.dat"];
	
	FILE *fp = fopen([szFile cStringUsingEncoding:NSASCIIStringEncoding],"rb+");
    
	if (fp == nil) 
    {
        g_gameInfo.isSoundOn = YES;
        g_gameInfo.isGraveOn = NO;
        g_gameInfo.isSmokeOn = NO;
        g_gameInfo.isGetBloodINAPP = NO;
        
        g_gameInfo.scoreTrack1 = 0;
        g_gameInfo.scoreTrack2 = 0;
        g_gameInfo.scoreTrack3 = 0;
        g_gameInfo.scoreTrack4 = 0;
        g_gameInfo.scoreTrack5 = 0;
        g_gameInfo.scoreTrack6 = 0;
        g_gameInfo.scoreTrack7 = 0;
        g_gameInfo.scoreTrack8 = 0;
        g_gameInfo.scoreTrack9 = 0;
        g_gameInfo.scoreTrack10 = 0;
        
        g_gameInfo.trackNum = 0;
    }
    else
    {
        fread(&g_gameInfo, sizeof(struct GAMEINFO), 1, fp);
        fclose(fp);	
    }
}

BOOL game_initialize()
{
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	SCREEN_WIDTH = winSize.width;
	SCREEN_HEIGHT = winSize.height;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		kYForIPhone = 1;
		kXForIPhone = 1;
	}
	else {
        if ([[UIDevice currentDevice] systemVersion].floatValue>7.2) {
            kYForIPhone = [[UIScreen mainScreen] bounds].size.height/768;
            kXForIPhone = [[UIScreen mainScreen] bounds].size.width/1024;
        }
        else {
            kYForIPhone = [[UIScreen mainScreen] bounds].size.width/768.0f;
            kXForIPhone = [[UIScreen mainScreen] bounds].size.height/1024.0f;
        }
    }
	
	if ( !initAnimation() ){
		return FALSE;
	}
	
	if ( loadSounds() == FALSE) {
		return FALSE;
	}
	
    loadUserInfo();
    
	return TRUE;
}

BOOL allSoundPause()
{
    if (g_gameInfo.isSoundOn == YES) {
        sd_menuback.volume = 1.0f;
        sd_button.volume = 1.0f;
        sd_delay.volume = 1.0f;
        sd_fire.volume = 1.0f;
        sd_jump[0].volume = 1.0f;
        sd_jump[1].volume = 1.0f;
        sd_jump[2].volume = 1.0f;
    }
    else {
        sd_menuback.volume = 0.0f;
        sd_button.volume = 0.0f;
        sd_delay.volume = 0.0f;
        sd_fire.volume = 0.0f;
        sd_jump[0].volume = 0.0f;
        sd_jump[1].volume = 0.0f;
        sd_jump[2].volume = 0.0f;
    }
    
    return  TRUE;
}
BOOL game_release()
{
    
	return TRUE;
}

void saveUserInfo()
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *szFile = [documentsDirectory stringByAppendingPathComponent:@"Info.dat"];
	
	FILE *fp = fopen([szFile cStringUsingEncoding:NSASCIIStringEncoding],"wb+");
	
	if (fp == nil)
		return ;
    
    fwrite(&g_gameInfo, sizeof(struct GAMEINFO), 1, fp);
    
	fclose(fp);
}
