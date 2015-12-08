//
//  tapPaperPointStore.m
//  tapPaper
//
//  Created by Vincent_D on 15/8/5.
//  Copyright (c) 2015年 Vincent_D. All rights reserved.
//

#import "tapPaperPointStore.h"


@implementation tapPaperPointStore

+ (instancetype)sharePoints
{
    static tapPaperPointStore * points;
    
    if (!points) {
        points = [[self alloc] init];
    }

    return points;
    
}

- (instancetype)init
{
    if (self = [super init]) {
        self.points = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (NSArray *)allPoints
{
    return self.allPoints;
}

- (void)addTabedPoint:(CGPoint)point
{
    [self.points addObject:[NSValue valueWithCGPoint:point]];
}

@end
