//
//  tapPaperMain.h
//  tapPaper
//
//  Created by Vincent_D on 15/8/2.
//  Copyright (c) 2015年 Vincent_D. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface tapPaperMain : UIViewController

@property (nonatomic) BOOL isPlaySound;

//游戏模式FLAG
@property (nonatomic) BOOL isSingleGame;
@property (nonatomic) BOOL  isHardMode;
@property (nonatomic) BOOL  isTimeMode;

@property (nonatomic, weak) id deligate;

@end
