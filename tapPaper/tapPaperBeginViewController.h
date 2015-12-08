//
//  tapPaperBeginViewController.h
//  tapPaper
//
//  Created by Vincent_D on 15/8/6.
//  Copyright (c) 2015年 Vincent_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tapPaperBeginView.h"
#import "AchieveStore.h"

@interface tapPaperBeginViewController : UIViewController

@property  (nonatomic) int totleTapCountNumber;

@property (nonatomic) int totleWinCountumber;


- (void)swiftSound;

- (void)loadAchiView;

- (void)loadSingleGame;

- (void)loadBattleGame;

- (void)loadTimeGame;

- (void)loadHardGame;

@end
