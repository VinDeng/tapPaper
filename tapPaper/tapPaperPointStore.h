//
//  tapPaperPointStore.h
//  tapPaper
//
//  Created by Vincent_D on 15/8/5.
//  Copyright (c) 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface tapPaperPointStore : NSObject

@property (nonatomic)  NSMutableArray *points;

+ (instancetype)sharePoints;

- (void)addTabedPoint:(CGPoint)Point;

- (NSArray *)allPoints;

@end
