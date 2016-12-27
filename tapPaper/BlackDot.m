
//
//  bigDot.m
//  tapPaper
//
//  Created by Vincent_D on 16/1/20.
//  Copyright © 2016年 Vincent_D. All rights reserved.
//

#import "BlackDot.h"

@implementation BlackDot

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.peaceId = 0;
        self.happyId = 0;
        self.sadId = 0;
        
        [self setupCache];
    }
    return self;
}

- (void)setupCache
{
    
    ////载入图片文件到内存中
    NSString *path;
    path = [[NSBundle mainBundle] pathForResource:@"blackDotNormal" ofType:@"jpg"];
    UIImage *peaceImg = [[UIImage alloc] initWithContentsOfFile:path];
    
    path = [[NSBundle mainBundle] pathForResource:@"blackDotHappy" ofType:@"jpg"];
    
    UIImage * happyImg= [[UIImage alloc] initWithContentsOfFile:path];
    
    path = [[NSBundle mainBundle] pathForResource:@"blackDotSad" ofType:@"jpg"];
    
    UIImage *sadImg = [[UIImage alloc] initWithContentsOfFile:path];
    
    
    
    self.dotViewImages = [NSArray arrayWithObjects:peaceImg,happyImg,sadImg, nil];
    
    ////载入音频文件到内存中
    path = [[NSBundle mainBundle] pathForResource:@"black_dot_normal" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    SystemSoundID tempId = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(tempId));
    self.peaceId = tempId;
    tempId = 0;
    
    path = [[NSBundle mainBundle] pathForResource:@"black_dot_happy" ofType:@"wav"];
    url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(tempId));
    self.happyId = tempId;
    tempId = 0;
    
    
    path = [[NSBundle mainBundle] pathForResource:@"black_dot_sad" ofType:@"wav"];
    url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(tempId));
    self.sadId = tempId;
    tempId = 0;
    
    ///载入文本文件到内存中
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    
    NSArray *peaceSpeech = [NSArray arrayWithObjects:@"......",@"&*UHBo99HHjo",@"我ui来自虚89h空h",@"我&***J饿了", nil];
    NSArray *happySpeech = [NSArray arrayWithObjects:@"把A你jks的灵88pO魂Hj9给我",@"阿塔**&（ni）斯必须死",@"for ?!&*(Auir", nil];
    NSArray *sadSpeech = [NSArray arrayWithObjects:@"我曾是*(*Lz神之长子",@"sssSsSsSSSsss",@"En taro darkVoid", nil];
    
    tempArr[peace] = peaceSpeech;
    tempArr[happy] = happySpeech;
    tempArr[sad] = sadSpeech;
    
    self.dotSpeech = tempArr;
    
}


//- (NSString *)saySomeThingInThisEmotion:(emotion)aEmotion
//{
//    switch (aEmotion) {
//        case peace:
//            AudioServicesPlaySystemSound(self.peaceId);
//            break;
//        case happy:
//            AudioServicesPlaySystemSound(self.happyId);
//            break;
//        case sad:
//            AudioServicesPlaySystemSound(self.sadId);
//            break;
//        default:
//            break;
//    }
//    NSInteger len = ((NSArray *)self.dotSpeech[aEmotion]).count;
//    NSInteger randomNum = arc4random()%len;
//    return self.dotSpeech[aEmotion][randomNum];
//}
//
//- (UIImage *)imageOfThisEmotion:(emotion)aEmotion
//{
//    return self.dotViewImages[aEmotion];
//}

@end
