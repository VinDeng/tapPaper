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

@interface tapPaperBeginViewController ()

@property (nonatomic) BOOL isPlaySound;
@property (nonatomic) tapPaperBeginView *beginView;

@end

@implementation tapPaperBeginViewController

- (instancetype) init
{
    self = [super init];
    
    if (self) {
       self.beginView = [[tapPaperBeginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
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

- (void)loadAchiView
{
    tapPaperAchievements *achievement = [[AchieveStore shareDate] achievement];
    
    _totleTapCountNumber = achievement.totleTapCountNumber;
    
    _totleWinCountumber = achievement.totleWinCountumber;
    
    [self.beginView requestAchievements];
    
    [self.beginView refreshScore];
    
    NSLog(@"%d,%d", _totleWinCountumber,_totleTapCountNumber);
    
    [self.view setNeedsDisplay];
    
}

- (void)loadSingleGame
{
    tapPaperMain *singleGame = [[tapPaperMain alloc] init];
    
    singleGame.isPlaySound = self.isPlaySound;
    
    singleGame.isSingleGame = YES;
    
    singleGame.isHardMode = NO;
    
    singleGame.deligate = self;
    
    [self presentViewController:singleGame animated:YES completion:nil];
}

- (void)loadBattleGame
{
    tapPaperMain *BattleGame = [[tapPaperMain alloc] init];
    
    BattleGame.isPlaySound = self.isPlaySound;
    
    BattleGame.isSingleGame = NO;
    
    BattleGame.isHardMode = NO;
    
    BattleGame.deligate = self;
    
    [self presentViewController:BattleGame animated:YES completion:nil];
}

- (void)loadTimeGame
{
    tapPaperMain *timeGame = [[tapPaperMain alloc] init];
    
    timeGame .isPlaySound = self.isPlaySound;
    
    timeGame .isSingleGame = YES;
    
    timeGame .isHardMode = NO;
    
    timeGame .isTimeMode = YES;
    
    timeGame .deligate = self;
    
    [self presentViewController:timeGame animated:YES completion:nil];
}

- (void)loadHardGame
{
    tapPaperMain *hardGame = [[tapPaperMain alloc] init];
    
    hardGame.isPlaySound = self.isPlaySound;
    
    hardGame.isSingleGame = YES;
    
    hardGame.isHardMode = YES;
    
    hardGame.deligate = self;
    
    [self presentViewController:hardGame animated:YES completion:nil];
}

@end
