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
#import "TapPaperBeginView.h"

@interface TapPaperBeginView ()

@property (nonatomic) CGFloat viewHeight;

@property (nonatomic) CGFloat viewWidht;

@property (nonatomic) UIButton *soundButton;

@property (nonatomic) UIButton *achievementButton;

@property (nonatomic) UILabel *totleTapCountLabel;

@property (nonatomic) UILabel *totleWinCountLabel;

@property  (nonatomic) int totleTapCountNumber;

@property (nonatomic) int totleWinCountumber;

@property (nonatomic) UIColor *buttonBackGround;

@property (nonatomic)UITapGestureRecognizer *tap;

@property (nonatomic)UILabel *spriteWordsLabel;

- (void)addButton;

- (void)addLabel;

- (void)requestAchievements;

- (void)addSprite;
@end

@implementation TapPaperBeginView

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(TapPaperBeginViewController *)bvc
{
    self.deligate = bvc;
   return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _viewHeight = [UIScreen mainScreen].bounds.size.height;
        _viewWidht = [UIScreen mainScreen].bounds.size.width;
        self.spriteWordsLabel = nil;
        
        NSLog(@"%f,%f",_viewWidht,_viewHeight);
        
        _buttonBackGround = [UIColor colorWithRed:kUB_Red green:kUB_Green blue:kUB_Blue alpha:1.0];
        
        [self addLabel];
        
        [self addButton];
        
        [self refreshScore];
        
        [self addSprite];
        
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
//    self.achievementButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//
//    self.achievementButton.frame = ButtonlRect;
//    
//    self.achievementButton.layer.cornerRadius = 10.0;
//    
//    self.achievementButton.center = CGPointMake(_viewWidht*6/9, _viewHeight/16);
//    
//    self.achievementButton.backgroundColor = self.buttonBackGround;
//    
//    [self.achievementButton setTitle:@"成就" forState:UIControlStateNormal];
//    
//    [self.achievementButton addTarget:self.deligate action:@selector(loadAchiView) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self addSubview:self.achievementButton];

    
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
    
    
    ////////////// BUG FIXING CODE
    
    
    double height = _viewWidht/8;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        height /= 2;
    }
    ///////////////// 广告入口
    CGRect adButtonRect = CGRectMake(0, 0, _viewHeight/8, height);
    
    UIButton *adButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    adButton.layer.cornerRadius = 10;
    
    [adButton setTitle:@"日行一善" forState:UIControlStateNormal];
    
    [adButton addTarget:self.deligate action:@selector(loadAdView) forControlEvents:UIControlEventTouchUpInside];

    adButton.frame = adButtonRect;
    
    adButton.center = CGPointMake(_viewWidht/2, (_viewHeight/2 + _viewHeight*5/8 + _viewWidht/4)/2 );
    
    adButton.backgroundColor = self.buttonBackGround;
    
    [self addSubview:adButton];
    
    ////////////// 进入游戏模式入口按钮
    


    CGRect buttonRect = CGRectMake(0, 0, _viewHeight/8, height);
    
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
    
    timeGame.center = CGPointMake(_viewWidht*3/8, _viewHeight*7/8 + 5);
    
    timeGame.backgroundColor = self.buttonBackGround;
    
    [timeGame setTitle:@"秒杀模式" forState:UIControlStateNormal];
    
    [timeGame addTarget:self.deligate action:@selector(loadTimeGame) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:timeGame];
    ///计时模式
    
    UIButton *hardGame = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    hardGame.layer.cornerRadius = 10.0;
    
    hardGame.frame = buttonRect;
    
    hardGame.center = CGPointMake(_viewWidht*5/8, _viewHeight*7/8 + 5);
    
    hardGame.backgroundColor = self.buttonBackGround;
    
    [hardGame setTitle:@"作死模式" forState:UIControlStateNormal];
    
    [hardGame addTarget:self.deligate action:@selector(loadHardGame) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:hardGame];
    
    ///困难模式
}

- (void)addLabel
{

    //2016.1.17 添加自适配字体
    NSString *labelString = @"点 点";
  
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    [label setNumberOfLines:0];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    
    label.font = [UIFont fontWithName:@"Helvetica" size:38];
    CGSize labelMaxSize = CGSizeMake(_viewWidht/2, _viewHeight/2);
    
    NSDictionary *dic = @{NSFontAttributeName:label.font};
    
    CGRect labelRect = [labelString boundingRectWithSize:labelMaxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil];
    
    label.frame = CGRectMake(0, 0, labelRect.size.width, labelRect.size.height);
    label.center = CGPointMake(_viewWidht/2, _viewHeight/2 - 50);
    label.text = labelString;
    label.textAlignment = UITextBorderStyleRoundedRect;
    label.layer.cornerRadius = 10.0;
    
    dic = nil;
    
    [self addSubview:label];
}

- (void)addSprite
{

    Dot *aDot = ((TapPaperBeginViewController *)self.deligate).myDot;
    
   UIImage *sprite = [aDot imageOfThisEmotion:peace];

    _spriteView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    _spriteView.center = CGPointMake(_viewWidht*7/9, _viewHeight/16 + 70);
    _spriteView.image = sprite;
    
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self.deligate action:@selector(tapSprite)];
    [_spriteView addGestureRecognizer:_tap];
    _spriteView.userInteractionEnabled = YES;

    [self addSubview:_spriteView];
}


- (void)spriteSay:(NSString *)words
{
    if (self.spriteWordsLabel) {
        [self.spriteWordsLabel removeFromSuperview];
        self.spriteWordsLabel = nil;
    }
    
    self.spriteWordsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.spriteWordsLabel.numberOfLines = 0;
    self.spriteWordsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.spriteWordsLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    CGSize labelMaxSize = CGSizeMake(_viewWidht/2, _viewHeight/2);
    NSDictionary *dic = @{NSFontAttributeName:self.spriteWordsLabel.font};
    CGRect labelRect = [words boundingRectWithSize:labelMaxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil];
    dic = nil;
    self.spriteWordsLabel.frame = CGRectMake(0, 0, labelRect.size.width, labelRect.size.height);
    
    CGPoint centerPoint = CGPointMake(0, 0);
    centerPoint.y = self.spriteView.center.y;
    centerPoint.x = (self.spriteView.frame.origin.x - labelRect.size.width/2);
    self.spriteWordsLabel.center = centerPoint;
    
    self.spriteWordsLabel.text = words;
    
    [self addSubview:self.spriteWordsLabel];
    
    [self setNeedsDisplay];
    
}

#pragma mark -
#pragma mark 声音开关
- (void)changeSoundLabel
{
    
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
