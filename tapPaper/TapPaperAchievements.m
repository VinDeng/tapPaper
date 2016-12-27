//
//  tapPaperAchievements.m
//  tapPaper
//
//  Created by Vincent_D on 15/8/9.
//  Copyright (c) 2015年 Vincent_D. All rights reserved.
//

#import "tapPaperAchievements.h"

@implementation TapPaperAchievements

#pragma mark -
#pragma mark 归档代理方法实现
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.totleTapCountNumber forKey:@"totleTapCountNumber"];

    [aCoder encodeInt:self.totleWinCountumber forKey:@"totleWinCountumber"];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
       _totleTapCountNumber = [aDecoder decodeIntForKey:@"totleTapCountNumber"];
       _totleWinCountumber = [aDecoder decodeIntForKey:@"totleWinCountumber"];
    }
    return self;
}

@end
