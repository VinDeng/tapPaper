//
//  AchieveStore.m
//  tapPaper
//
//  Created by Vincent_D on 15/8/8.
//  Copyright (c) 2015年 Vincent_D. All rights reserved.
//

#import "AchieveStore.h"

@interface AchieveStore ()

- (instancetype)initPrivate;

@end

@implementation AchieveStore

+ (instancetype)shareDate
{
    static AchieveStore * achieveStore = nil; //单例化
    
    if (!achieveStore) {
        achieveStore = [[self alloc] initPrivate];
    }
    return achieveStore;
}

- (instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        NSString *path = [self storePath];
        
        _achievement = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!_achievement) {
            _achievement = [[tapPaperAchievements alloc] init];
        }
    }
    
    return self;
}


- (void)saveChange
{
    NSString *path = [self storePath];

    if ([NSKeyedArchiver archiveRootObject:self.achievement toFile:path]) {
        NSLog(@"save succeed");
    } else{
        NSLog(@"save fail");
    }
}

- (NSString *)storePath
{
    NSArray *doucumentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [doucumentDirectories firstObject];//获取根目录
    return [documentDirectory stringByAppendingPathComponent:@"item.archive"];
}

- (tapPaperAchievements *)achievements
{
    return self.achievement;
}




@end
