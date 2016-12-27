//
//  adView.m
//  tapPaper
//
//  Created by Vincent_D on 16/1/25.
//  Copyright © 2016年 Vincent_D. All rights reserved.
//

#import "AdView.h"

@interface AdView ()


@property (nonatomic)UIImageView *spriteView;
@property (nonatomic)UIButton *exitButton;

@property (nonatomic)double viewHeigth;
@property (nonatomic)double viewWidth;
@property (nonatomic)UITapGestureRecognizer *tap;

@end

@implementation AdView

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(AdViewController *)avc
{
    self.delegate = avc;
    
    self.viewHeigth = [UIScreen mainScreen].bounds.size.height;
    self.viewWidth = [UIScreen mainScreen].bounds.size.width;
    
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self addSprite];

        [self addExitButton];

    }
    
    return self;
}

- (void)addExitButton
{
    ////////////////
    CGRect ButtonlRect = CGRectMake(0, 0, 65, 20);
    
    self.exitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    self.exitButton.frame = ButtonlRect;
    
    self.exitButton.center = CGPointMake(_viewWidth*8/9, 30);
    
    self.exitButton.backgroundColor = [UIColor whiteColor];
    
    NSString *string = @"退出";
    
    [self.exitButton setTitle:string forState:UIControlStateNormal];
    
    [self.exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.exitButton];
    
}

- (void)addSprite
{
    self.spriteView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.spriteView.center = CGPointMake(_viewWidth/2, _viewHeigth*1/4 + 20);
    self.spriteView.image = [self.delegate.myDot imageOfThisEmotion:peace];
    
//    [self.spriteView setBackgroundColor:[UIColor blackColor]];
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(showJoke)];
    
    [self.spriteView addGestureRecognizer:self.tap];
    
    
    self.spriteView.userInteractionEnabled = YES;
    
    [self addSubview:self.spriteView];
    

}



- (void)showJoke:(NSString *)joke
{
    if (self.jokeLabel) {
        [self.jokeLabel removeFromSuperview];
        self.jokeLabel = nil;
    }
    
    self.jokeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    self.jokeLabel.numberOfLines = 0;
    self.jokeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.jokeLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    CGSize labelMaxSize = CGSizeMake(_viewWidth - 50, _viewHeigth/2);
    NSDictionary *dic = @{NSFontAttributeName:self.jokeLabel.font};
    CGRect labelRect = [joke boundingRectWithSize:labelMaxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil];
    self.jokeLabel.frame = CGRectMake(0, 0, labelRect.size.width, labelRect.size.height);
    CGPoint center = CGPointMake(_viewWidth/2, _viewHeigth*2/3);
    self.jokeLabel.center = center;
    self.jokeLabel.text = joke;
    
    [self addSubview:self.jokeLabel];
    
    [self setNeedsDisplay];
}


- (void)exit
{
    NSLog(@"EXIT");
    
    [self.spriteView removeGestureRecognizer:self.tap];
    
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}
//- (void)addJokeLabel
//{
//    
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
