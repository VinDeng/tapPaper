//
//  tapPaperMain.m
//  tapPaper
//
//  Created by Vincent_D on 15/8/2.
//  Copyright (c) 2015年 Vincent_D. All rights reserved.
//

#import "AchieveStore.h"
#import "tapPaperMain.h"
#import <UIKit/UIKit.h>
#import "tapPaperView.h"

#define HOLERADIUS 20 //洞的半径
#define TIME 5

@interface tapPaperMain ()

@property (nonatomic) CGPoint holePosition;

@property (nonatomic) UITapGestureRecognizer *tap;

@property (nonatomic) BOOL computerTurn;

@property (nonatomic) int theWinner;

@property (nonatomic) NSTimer *timer;

@property (nonatomic) float coolTime;

@property (nonatomic) float stepTime;

@property (nonatomic) long computerWin;

@property (nonatomic) long playerWin;

@property (nonatomic) UILabel *timeLabel;

@property (nonatomic) int tapCount;

@property (nonatomic) int totleTapCount;

@property (nonatomic) UILabel *tapCountLabel; //胜利次数

@property (nonatomic) UILabel *totleTapCountLabel;// 总点击数

@property (nonatomic) UILabel *loseLabel; //败北次数

- (void)initDate; //初始化数据

- (void)addGesture; //添加手势

- (void)gameOver; //结束游戏

- (void)readyTimer;

- (void)tapPaper:(CGPoint)location; //点击动作

- (void)showAnimation:(int)distent andMarkThePoint:(CGPoint)Point; //点击动画

- (void)checkIsHoleClicked:(CGPoint)point;//判定是否点中洞穴

- (void)computerTurn:(CGPoint)holePosition andPlayerDistent:(int)distent inHardMode:(BOOL)hardMode; //电脑回合

- (void)exit;
@end

@implementation tapPaperMain

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDate];  //游戏数据准备
    
    [self addGesture]; //添加手势
    
    [self addLabel];  //添加屏幕文字
    
    [self refreshScore]; //刷新分数
    
    if (_isTimeMode) {
        
        [self readyTimer]; //定时
        
        [self timeStart];  //开始计时
    }
    
}

#pragma mark -
#pragma mark 准备需要用的数据
- (void)initDate
{

    self.holePosition = [self getAPointRandomly]; //生成一个目标洞
    
}

#pragma mark -
#pragma mark 删除手势

- (void)removeGesture
{
    if (self.tap) {
        [self.view removeGestureRecognizer:self.tap];
        self.tap = nil;
    }
}

#pragma mark -
#pragma mark 添加手势

- (void)addGesture
{
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPaper:)]; //点击触发方法
    
    [self.view addGestureRecognizer:self.tap];
    
    self.view.userInteractionEnabled = YES; //开启交互
}

#pragma mark -
#pragma mark 点击屏幕
- (void)tapPaper:(CGPoint)location
{
    


    if (!_computerTurn) { //判定玩家回合还是电脑回合
        [self checkIsHoleClicked:[self.tap locationInView:self.view]];
        //检查玩家是否点中洞
        _totleTapCount ++; //点击数+1
        
        _totleTapCountLabel.text = [NSString stringWithFormat:@"%d",_totleTapCount];
        
    }else{
        [self checkIsHoleClicked:location]; //判定电脑有否点中洞
    }
    

    
}

#pragma mark -
#pragma mark 重启游戏
- (void)restartGame
{
    self.computerTurn = NO;
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self viewDidLoad];
}
#pragma mark -
#pragma mark 游戏结束
- (void)gameOver
{
    if (_timeLabel) {
        [self.timer invalidate];
        self.timer = nil;
    }
    switch ((int)self.computerTurn) {
        case 0:
        {
                NSString *str = @"恭喜一发入魂！再来一次吧";
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"爽够了" otherButtonTitles:@"再来一局", nil];
            alertView.tag = 101;
            [alertView show];
        }
            break;
        case 1:
        {   NSString *str = @"你被电脑一发入魂了，下次加油吧";
            
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"爽够了" otherButtonTitles:@"再来一局", nil];
            
            alertView.tag = 101;
            [alertView show];
            break;
        }
        default:
        {
            NSString *str = @"一发入魂";
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"爽够了" otherButtonTitles:@"再来一局", nil];
            
            alertView.tag = 101;
            [alertView show];
        }
            break;
    }
}

#pragma mark -
#pragma mark 游戏结束弹窗
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"%ld",buttonIndex);
    if (buttonIndex == 1) {
        [self restartGame];
    } else if (buttonIndex == 0) {
        [self exit];
    }
}

#pragma mark -
#pragma mark 判定方法
- (void)checkIsHoleClicked:(CGPoint)point
{
    
    int distent = [self distentBetweenPointOne:point andPointTwo:self.holePosition]; //取点之间距离
    
    [self showAnimation:distent andMarkThePoint:point]; //播放点击动画
    
    if (distent < 24) { //距离小于判定距离
//        NSLog(@"捅破了"); 调试代码
        
        if (!_computerTurn) { //玩家回合
            self.tapCount ++;
            self.tapCountLabel.text = [NSString stringWithFormat:@"%d",self.tapCount];
        }
        
        [self gameOver];
        
    }else{ // 距离大于判定距离
//        NSLog(@"没捅破"); 调试代码
        
        if (_isSingleGame) {  //双人游戏
                    _computerTurn = ! _computerTurn; //跳过电脑回合
        }

        
        if (_isSingleGame && _computerTurn) { //单人游戏而且处在电脑回合
            
            [self computerTurn:_holePosition andPlayerDistent:distent inHardMode:self.isHardMode]; //电脑判定方法

            }
        
        return;
        
    }
    
    
}

- (int)distentBetweenPointOne:(CGPoint) point1 andPointTwo:(CGPoint) point2
{
   return  (int)sqrt(pow(point1.x - point2.x, 2) + pow(point1.y - point2.y, 2));
}

#pragma mark -
#pragma mark 点击动画
- (void)showAnimation:(int)distent andMarkThePoint:(CGPoint)point
{
    switch (distent/70) {
        case 0:{ //距离很近
              [UIView animateWithDuration:0.5 animations:
               ^{
                   [self.view setBackgroundColor:[UIColor greenColor]];
                   [self.view setBackgroundColor:[UIColor whiteColor]];
                   [self removeGesture];
               } completion:^(BOOL finished) {
                    //将点击的点显示到屏幕上
            [self drawCicleInPoint:point];
                                }];
            [self addGesture];
    
        }

            break;
        case 1: //距离较近
        {
            [UIView animateWithDuration:0.5 animations:
             ^{
                 [self.view setBackgroundColor:[UIColor yellowColor]];
                 [self.view setBackgroundColor:[UIColor whiteColor]];
             } completion:^(BOOL finished) {
                 [self drawCicleInPoint:point];
             }];
        }
            break;
        case 2: //距离一般
        {
                       [UIView animateWithDuration:0.5 animations:
             ^{
                 [self.view setBackgroundColor:[UIColor orangeColor]];
                 [self.view setBackgroundColor:[UIColor whiteColor]];
             } completion:^(BOOL finished) {
             [self drawCicleInPoint:point];
             }];
        }
            break;
        default: //距离很远
        {
            [UIView animateWithDuration:0.5 animations:
             ^{
                 [self.view setBackgroundColor:[UIColor redColor]];
                 [self.view setBackgroundColor:[UIColor whiteColor]];
             } completion:^(BOOL finished) {
             [self drawCicleInPoint:point];
             }];
        }

            break;
    }
}

#pragma mark -
#pragma mark 电脑判定方法
- (void)computerTurn:(CGPoint)holePosition andPlayerDistent:(int)distent inHardMode:(BOOL)isHardMode
{

    CGPoint computerTurnPoint ,anotherComputerTurnPoint;
    
    int distant1, distant2;

    computerTurnPoint  = [self getAPointRandomly]; //取得一个点
    
    
     while ((distant1 = [self distentBetweenPointOne:computerTurnPoint andPointTwo:self.holePosition] )> distent)
     {
         computerTurnPoint  = [self getAPointRandomly];
     }
    
    if (isHardMode) {
        anotherComputerTurnPoint = [self getAPointRandomly];
        
        while ( (distant2 = [self distentBetweenPointOne:anotherComputerTurnPoint andPointTwo:self.holePosition] )> distent)
        {
            anotherComputerTurnPoint  = [self getAPointRandomly];
        }
    }
    //不断取点，直到点与洞的距离小于上一下玩家点击的点与洞的距离
    
    
    NSLog(@"computer's distent is %d \n player's distent is %d",[self distentBetweenPointOne:computerTurnPoint andPointTwo:self.holePosition],distent);
    
    if (self.isHardMode) {  //是否困难模式
        
        [self drawCicleInPoint:(distant2 < distant1 ? computerTurnPoint : anotherComputerTurnPoint)];
        
        [self tapPaper: (distant2 > distant1 ? computerTurnPoint : anotherComputerTurnPoint) ];
        
        //电脑额外获得一个回合
    }else{
    
    [self tapPaper:computerTurnPoint]; //电脑点击回合
    
    }
    
}
#pragma mark -
#pragma mark 画点方法
- (void)drawCicleInPoint:(CGPoint)point
{
    int distent = [self distentBetweenPointOne:point andPointTwo:self.holePosition];
    
    UIColor *color;
    
    switch (distent/70) //按距离确定颜色
    {
        case 0: color = [UIColor greenColor]; break;
        case 1: color = [UIColor yellowColor]; break;
        case 2: color = [UIColor orangeColor]; break;
        default: color = [UIColor redColor]; break;
       
    }
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    
    [self.view addSubview:img];
    UIGraphicsBeginImageContext(img.frame.size);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    //
    
    [path setLineWidth:1];
    [color setFill];
    [path addArcWithCenter:point radius:4 startAngle:0.0 endAngle:180.0 clockwise:YES];
    //
    [path fill];
    //
    img.image  = UIGraphicsGetImageFromCurrentImageContext();
    //
    UIGraphicsEndImageContext();
    
    
}

#pragma mark -
#pragma mark 取随机点方法
- (CGPoint)getAPointRandomly
{
    int width = self.view.bounds.size.width;
    
    int height = self.view.bounds.size.height;
    
    
    int  x = arc4random()%width - 50;
    
    int  y = arc4random()%height - 70;
    

    
    while (x <= 50) {
        x = arc4random()%width - 50;
    }
    
    while (y <= 70) {  //
        y = arc4random()%height - 70;
    }
    
    //反复取点避免取到屏幕边缘
    
    NSLog(@"%d,%d",x,y);
    
    return CGPointMake((float)x, (float)y);
}

#pragma mark -
#pragma mark 退出游戏方法
- (void)exit
{
    AchieveStore *achieveStore = [AchieveStore shareDate];
    //调用存放成就的单例对象
 
    [achieveStore achievement].totleTapCountNumber += self.totleTapCount;
    
    [achieveStore achievement].totleWinCountumber += self.tapCount;
    
    [achieveStore saveChange]; //归档存储
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark 计时方法1
- (void)timeStart
{
     self.timer = [NSTimer scheduledTimerWithTimeInterval:_stepTime target:self selector:@selector(coolDownCount) userInfo:nil repeats:YES];
}

#pragma mark -
#pragma mark 计时方法2
- (void)coolDownCount
{
    _coolTime = _coolTime - _stepTime;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%d",(int)_coolTime];
    
    if (_coolTime == 0) {
        [self timeOver];
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark -
#pragma mark 预设时间
- (void)readyTimer
{
    if (!_timeLabel) {
    
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 65)];
        
        _timeLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,35);
    
    _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
    
        
    }
    
    [self.view addSubview:_timeLabel];
    
    _coolTime = TIME;
    _stepTime = 1.0f;
    
    _timeLabel.text = [NSString stringWithFormat:@"%d", (int)_coolTime];

}

#pragma mark -
#pragma mark 时间结束
- (void)timeOver
{
    NSString *str = @"时间够";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"爽够了" otherButtonTitles:@"再来一局", nil];
    
    alertView.tag = 102;
    [alertView show];
}

#pragma mark -
#pragma mark 添加屏幕元素
- (void)addLabel //点击数
{
    CGRect labelRect = CGRectMake(0, 0, 20, 65);
    
    _tapCountLabel = [[UILabel alloc] initWithFrame:labelRect];
    
    _tapCountLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width* 8 / 9, [UIScreen mainScreen].bounds.size.height / 16);
    
    _tapCountLabel.text = [NSString stringWithFormat:@"%d",_tapCount];
    
    _totleTapCountLabel = [[UILabel alloc] initWithFrame:labelRect];
    
    _totleTapCountLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width* 7 / 9, [UIScreen mainScreen].bounds.size.height / 16);
    
    _totleTapCountLabel.text = [NSString stringWithFormat:@"%d",_totleTapCount];
    
    [self.view addSubview:_totleTapCountLabel];
    
    [self.view addSubview:_tapCountLabel];
}

#pragma mark -
#pragma mark 刷新分数
- (void)refreshScore
{   _tapCountLabel.text = [NSString stringWithFormat:@"%d",_tapCount];
    
    _totleTapCountLabel.text = [NSString stringWithFormat:@"%d",_totleTapCount];
    
    [self.view addSubview:_totleTapCountLabel];
    
    [self.view addSubview:_tapCountLabel];
}
@end
