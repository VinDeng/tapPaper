//
//  tapPaperBeginViewController.m
//  tapPaper
//
//  Created by Vincent_D on 15/8/6.
//  Copyright (c) 2015年 Vincent_D. All rights reserved.
//

#import "AchieveStore.h"
#import "tapPaperAchievements.h"
#import "tapPaperBeginViewController.h"
#import "tapPaperMain.h"
#import "bigDot.h"
#import "smallDot.h"
#import "blackDot.h"



@interface TapPaperBeginViewController ()


@property (nonatomic) TapPaperBeginView *beginView;


@end

@implementation TapPaperBeginViewController

- (instancetype) init
{
    self = [super init];
    
    if (self) {

        self.isPlaySound = YES;
        
        [self creatSprite];

        self.beginView = [[TapPaperBeginView alloc] initWithFrame:[UIScreen mainScreen].bounds andDelegate:self];
        
        _beginView.isPlaySound = self.isPlaySound;

        _beginView.deligate = self;
        
        
        
        self.view = self.beginView;
        
    }
    return self;
}

- (void)swiftSound
{
   self.isPlaySound = ! self.isPlaySound;
    
    _beginView.isPlaySound = self.isPlaySound;
    
    NSLog(@"%d",_beginView.isPlaySound);
    
    [self.beginView changeSoundLabel];
    
    [self.view setNeedsDisplay];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSLog(@"View will appear");
    
    [self loadAchiView];
    

    
}

#pragma mark-
#pragma mark创造精灵
- (void)creatSprite
{
    NSInteger randomNum = arc4random()%100;
//    NSInteger randomNum = 95;

    BOOL isBlackDot = randomNum >= 95;
    BOOL isBigDot = ( (randomNum < 95) && (randomNum >= 80) );
    
    if (isBlackDot) {
        self.myDot = [[BlackDot
                       alloc] init];
    }else if (isBigDot){
        self.myDot = [[BigDot alloc] init];
    }else{
        self.myDot = [[SmallDot alloc]init];
    }
    
    self.myDot.delegate = self;
    
    return;
}

- (void)tapSprite
{
   NSInteger aEmotion = arc4random()%3;
    
   self.beginView.spriteView.image = [self.myDot dotViewImages][aEmotion];
   NSString *words = [self.myDot saySomeThingInThisEmotion:aEmotion];
    
   [self.beginView spriteSay:words];
}

#pragma mark-
#pragma mark读取成就数据


- (void)loadAchiView
{
    TapPaperAchievements *achievement = [[AchieveStore shareDate] achievement];
    
    _totleTapCountNumber = achievement.totleTapCountNumber;
    
    _totleWinCountumber = achievement.totleWinCountumber;
    
    [self.beginView requestAchievements];
    
    [self.beginView refreshScore];
    
    NSLog(@"%d,%d", _totleWinCountumber,_totleTapCountNumber);
    
    [self.view setNeedsDisplay];
    
}

#pragma mark-
#pragma mark进入游戏方法

- (void)loadSingleGame
{
    TapPaperMain *singleGame = [[TapPaperMain alloc] init];
    
    singleGame.isPlaySound = self.isPlaySound;
    
    singleGame.isSingleGame = YES;
    
    singleGame.isHardMode = NO;
    
    singleGame.deligate = self;
    
    [self presentViewController:singleGame animated:YES completion:nil];
}

- (void)loadBattleGame
{
    TapPaperMain *BattleGame = [[TapPaperMain alloc] init];
    
    BattleGame.isPlaySound = self.isPlaySound;
    
    BattleGame.isSingleGame = NO;
    
    BattleGame.isHardMode = NO;
    
    BattleGame.deligate = self;
    
    [self presentViewController:BattleGame animated:YES completion:nil];
}

- (void)loadTimeGame
{
    TapPaperMain *timeGame = [[TapPaperMain alloc] init];
    
    timeGame .isPlaySound = self.isPlaySound;
    
    timeGame .isSingleGame = YES;
    
    timeGame .isHardMode = NO;
    
    timeGame .isTimeMode = YES;
    
    timeGame .deligate = self;
    
    [self presentViewController:timeGame animated:YES completion:nil];
}

- (void)loadHardGame
{
    TapPaperMain *hardGame = [[TapPaperMain alloc] init];
    
    hardGame.isPlaySound = self.isPlaySound;
    
    hardGame.isSingleGame = YES;
    
    hardGame.isHardMode = YES;
    
    hardGame.deligate = self;
    
    [self presentViewController:hardGame animated:YES completion:nil];
}

- (void)loadAdView
{
    AdViewController *adv = [[AdViewController alloc] init];
    adv.myDot = self.myDot;
    [self presentViewController:adv animated:YES completion:nil];
}

#pragma mark-
#pragma mark禁止横屏
-(BOOL)shouldAutorotate
{
//    NSLog(@"use SA");
    return NO;
    
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
//    NSLog(@"use SIFO");
     return UIInterfaceOrientationMaskPortrait;
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{

//    NSLog(@"SATIO");
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
