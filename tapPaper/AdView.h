//
//  adView.h
//  tapPaper
//
//  Created by Vincent_D on 16/1/25.
//  Copyright © 2016年 Vincent_D. All rights reserved.
//
#import "AdViewController.h"
#import <UIKit/UIKit.h>

@interface AdView : UIView

@property (nonatomic)UILabel *jokeLabel;
@property (nonatomic, weak) AdViewController* delegate;


- (instancetype)initWithFrame:(CGRect)frame andDelegate:(AdViewController *)avc;
- (void)showJoke:(NSString *)joke;
- (void)addSprite;

@end
