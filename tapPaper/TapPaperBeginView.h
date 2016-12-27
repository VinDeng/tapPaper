//
//  tapPaperBeginView.h
//  tapPaper
//
//  Created by Vincent_D on 15/8/6.
//  Copyright (c) 2015年 Vincent_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapPaperBeginViewController.h"

@class TapPaperBeginViewController;

@interface TapPaperBeginView : UIView

@property (nonatomic, weak) id  deligate;

@property (nonatomic) BOOL isPlaySound; //声音开关
@property (nonatomic) UIImageView *spriteView;


- (instancetype)initWithFrame:(CGRect)frame andDelegate:(TapPaperBeginViewController *)bvc;

- (void)changeSoundLabel;  //开关声音方法

- (void)requestAchievements; //从归档文件中读取成就

- (void)refreshScore;  //刷新分数的方法

- (void)spriteSay:(NSString *)words;
@end
