//
//  adViewController.h
//  tapPaper
//
//  Created by Vincent_D on 16/1/25.
//  Copyright © 2016年 Vincent_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dot.h"
#import "TapPaperBeginViewController.h"
#import "JOYConnect.h"

@class Dot;

@interface AdViewController : UIViewController

@property (nonatomic)Dot *myDot;


- (void)showJoke;


@end
