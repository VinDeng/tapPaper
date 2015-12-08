//
//  tapPaperBeginView.m
//  tapPaper
//
//  Created by Vincent_D on 15/8/6.
//  Copyright (c) 2015年 Vincent_D. All rights reserved.
//
#define kUB_Red 245/255.0
#define kUB_Green 227/255.0
#define kUB_Blue 199/255.0

#import <UIKit/UIKit.h>
#import "tapPaperBeginView.h"

@interface tapPaperBeginView ()

@property (nonatomic) CGFloat viewHeight;

@property (nonatomic) CGFloat viewWidht;

@property (nonatomic) UIButton *soundButton;

@property (nonatomic) UIButton *achievementButton;

@property (nonatomic) UILabel *totleTapCountLabel;

@property (nonatomic) UILabel *totleWinCountLabel;

@property  (nonatomic) int totleTapCountNumber;

@property (nonatomic) int totleWinCountumber;

@property (nonatomic) UIColor *buttonBackGround;

- (void)addButton;

- (void)addLabel;

- (void)requestAchievements;

@end

@implementation tapPaperBeginView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _viewHeight = [UIScreen mainScreen].bounds.size.height;
        _viewWidht = [UIScreen mainScreen].bounds.size.width;
        
        NSLog(@"%f,%f",_viewWidht,_viewHeight);
        
        _buttonBackGround = [UIColor colorWithRed:kUB_Red green:kUB_Green blue:kUB_Blue alpha:1.0];
        
        [self addLabel];
        
        [self addButton];
        
//        [self requestAchievements];
        
        [self refreshScore];
        
    }
    return self;
}

#pragma mark -
#pragma mark添加按钮
- (void)addButton
{
    ////////////////声音开关
    CGRect ButtonlRect = CGRectMake(0, 0, 65, 20);
    
    self.soundButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    self.soundButton.frame = ButtonlRect;
    
    self.soundButton.center = CGPointMake(_viewWidht*8/9, _viewHeight/16);
    
    self.soundButton.backgroundColor = [UIColor whiteColor];
    
    NSString *string = self.isPlaySound ? @"开": @"关" ;
    
    [self.soundButton setTitle:[NSString stringWithFormat:@"声音:%@",string] forState:UIControlStateNormal];
    
    [self.soundButton addTarget:self.deligate action:@selector(swiftSound) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.soundButton];
    
    /////////////// 成就页面入口按钮
    self.achievementButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    self.achievementButton.frame = ButtonlRect;
    
    self.achievementButton.layer.cornerRadius = 10.0;
    
    self.achievementButton.center = CGPointMake(_viewWidht*6/9, _viewHeight/16);
    
    self.achievementButton.backgroundColor = self.buttonBackGround;
    
    [self.achievementButton setTitle:@"成就" forState:UIControlStateNormal];
    
    [self.achievementButton addTarget:self.deligate action:@selector(loadAchiView) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.achievementButton];

    
    ////////////// 左上角统计数据
    
    CGRect labelRect = CGRectMake(0, 0, 90, 20);
    
    self.totleTapCountLabel = [[UILabel alloc] initWithFrame:labelRect];
    
    self.totleTapCountLabel.center = CGPointMake((_viewWidht/9) +12, _viewHeight/16);
    
    self.totleTapCountLabel.text = [NSString stringWithFormat:@"点击数:%d",    _totleTapCountNumber];
    
//    self.totleTapCountLabel.backgroundColor = [UIColor blackColor];
    
    self.totleWinCountLabel = [[UILabel alloc] initWithFrame:labelRect];
    
    self.totleWinCountLabel.center = CGPointMake((_viewWidht/9) + 12, _viewHeight*1.7/16);
 
    self.totleWinCountLabel.text = [NSString stringWithFormat:@"胜利数:%d",self.totleWinCountumber];
    
    [self addSubview:self.totleTapCountLabel];
    
    [self addSubview:self.totleWinCountLabel];
    
    ////////////// 进入游戏模式入口按钮
    
    CGRect buttonRect = CGRectMake(0, 0, _viewHeight/8, _viewWidht/8);
    
    UIButton *singleGame = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    singleGame.layer.cornerRadius = 10.0;
    
    singleGame.frame = buttonRect;
    
    singleGame.center = CGPointMake(_viewWidht*3/8, _viewHeight*5/8 + _viewWidht/4);

    singleGame.backgroundColor = self.buttonBackGround;
    
    [singleGame setTitle:@"单人游戏" forState:UIControlStateNormal];
    
    [singleGame addTarget:self.deligate action:@selector(loadSingleGame) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:singleGame];
    
    ///单人游戏
    
    UIButton *battleGame = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    battleGame.layer.cornerRadius = 10.0;
    
    battleGame.frame = buttonRect;
    
    battleGame.center = CGPointMake(_viewWidht*5/8, _viewHeight*5/8 + _viewWidht/4);
    
    battleGame.backgroundColor = self.buttonBackGround;
    
    [battleGame setTitle:@"对战模式" forState:UIControlStateNormal];
    
    [battleGame addTarget:self.deligate action:@selector(loadBattleGame) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:battleGame];
    ///双人游戏
    
    UIButton *timeGame = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    timeGame.layer.cornerRadius = 10.0;
    
    timeGame.frame = buttonRect;
    
    timeGame.center = CGPointMake(_viewWidht*3/8, _viewHeight*7/8);
    
    timeGame.backgroundColor = self.buttonBackGround;
    
    [timeGame setTitle:@"秒杀模式" forState:UIControlStateNormal];
    
    [timeGame addTarget:self.deligate action:@selector(loadTimeGame) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:timeGame];
    ///计时模式
    
    UIButton *hardGame = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    hardGame.layer.cornerRadius = 10.0;
    
    hardGame.frame = buttonRect;
    
    hardGame.center = CGPointMake(_viewWidht*5/8, _viewHeight*7/8);
    
    hardGame.backgroundColor = self.buttonBackGround;
    
    [hardGame setTitle:@"作死模式" forState:UIControlStateNormal];
    
    [hardGame addTarget:self.deligate action:@selector(loadHardGame) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:hardGame];
    
    ///困难模式
}

- (void)addLabel
{
    CGRect labelRect = CGRectMake(0, 0, _viewWidht/4, _viewHeight/5);
    
    UILabel *Title = [[UILabel alloc] initWithFrame:labelRect];
    
    Title.center = CGPointMake(_viewWidht/2, _viewHeight/2-50);
    
    Title.text = @"点 点";
    
    Title.textAlignment = UITextBorderStyleRoundedRect;
    
    Title.layer.cornerRadius = 10.0;
    
    Title.font = [UIFont fontWithName:@"Helvetica" size:34];
    
    [self addSubview:Title];
    
}

#pragma mark -
#pragma mark 声音开关
- (void)changeSoundLabel
{
//    NSString *string = self.isPlaySound ? @"开": @"关" ;
    
    [self.soundButton setTitle:[NSString stringWithFormat:@"声音:%@",self.isPlaySound ? @"开": @"关"] forState:UIControlStateNormal];
    NSLog(@"%@" ,[NSString stringWithFormat:@"声音:%@",self.isPlaySound ? @"开": @"关"]);
}
#pragma mark -
#pragma mark 分数刷新
- (void)refreshScore
{
    [self requestAchievements];
    
        self.totleTapCountLabel.text = [NSString stringWithFormat:@"点击数:%d",    _totleTapCountNumber];
    
        self.totleWinCountLabel.text = [NSString stringWithFormat:@"胜利数:%d",self.totleWinCountumber];
    
    NSLog(@"refreshScore");
}
#pragma mark -
#pragma mark 读取成就
- (void)requestAchievements{
    self.totleWinCountumber = [[AchieveStore shareDate] achievement].totleWinCountumber;
    self.totleTapCountNumber = [[AchieveStore shareDate] achievement].totleTapCountNumber;
    
    NSLog(@"requestAchi");
}
@end
