//
//  tapPaperBeginView.h
//  tapPaper
//
//  Created by Vincent_D on 15/8/6.
//  Copyright (c) 2015年 Vincent_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tapPaperBeginViewController.h"
@class tapPaperBeginViewController;

@interface tapPaperBeginView : UIView

@property (nonatomic, weak) id  deligate;

@property (nonatomic) BOOL isPlaySound; //声音开关（未实装音效）

- (void)changeSoundLabel;  //开关声音方法

- (void)requestAchievements; //从归档文件中读取成就

- (void)refreshScore;  //刷新分数的方法
@end
