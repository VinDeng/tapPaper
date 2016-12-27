//
//  AchieveStore.h
//  tapPaper
//
//  Created by Vincent_D on 15/8/8.
//  Copyright (c) 2015年 Vincent_D. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TapPaperAchievements.h"

typedef enum achimentTypes  //成就类型
{   peopleWinNumber = 0,
    computerWinNumber,
    totleClickTimes,
}achimentTypes;

@interface AchieveStore : NSObject

//@property  (nonatomic) int totleTapCountNumber;
//
//@property (nonatomic) int totleWinCountumber;

+ (instancetype)shareDate;

@property (nonatomic) TapPaperAchievements *achievement;

- (TapPaperAchievements *)achievement;

- (void)saveChange;

- (NSString *)storePath;


@end
