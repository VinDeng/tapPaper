
//
//  bigDot.m
//  tapPaper
//
//  Created by Vincent_D on 16/1/20.
//  Copyright © 2016年 Vincent_D. All rights reserved.
//

#import "bigDot.h"

@implementation bigDot

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
    path = [[NSBundle mainBundle] pathForResource:@"bigDotNormal" ofType:@"jpg"];
    UIImage *peaceImg = [[UIImage alloc] initWithContentsOfFile:path];
    
    path = [[NSBundle mainBundle] pathForResource:@"bigDotHappy" ofType:@"jpg"];

    UIImage * happyImg= [[UIImage alloc] initWithContentsOfFile:path];
    
    path = [[NSBundle mainBundle] pathForResource:@"bigDotSad" ofType:@"jpg"];
    
    UIImage *sadImg = [[UIImage alloc] initWithContentsOfFile:path];
    

    
    self.dotViewImages = [NSArray arrayWithObjects:peaceImg,happyImg,sadImg, nil];
    
    ////载入音频文件到内存中
    path = [[NSBundle mainBundle] pathForResource:@"big_dot_normal" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    SystemSoundID tempId = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(tempId));
    self.peaceId = tempId;
    tempId = 0;
    
    path = [[NSBundle mainBundle] pathForResource:@"big_dot_happy" ofType:@"wav"];
    url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(tempId));
    self.happyId = tempId;
    tempId = 0;
    
    
    path = [[NSBundle mainBundle] pathForResource:@"big_dot_sad" ofType:@"wav"];
    url = [NSURL fileURLWithPath:path];

    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(tempId));
    self.sadId = tempId;
    tempId = 0;

    ///载入文本文件到内存中
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    
    NSArray *peaceSpeech = [NSArray arrayWithObjects:@"再摸我就咬你",@"加藤鹰都没我厉害",@"我可比我妹妹厉害多了", nil];
    NSArray *happySpeech = [NSArray arrayWithObjects:@"你个渣渣",@"乐胜乐胜",@"不作死就不会死，为什么不明白", nil];
    NSArray *sadSpeech = [NSArray arrayWithObjects:@"输..输给你什么的，人家才不会承认",@"你不看广告我没钱吃饭了啦",@"我...我没有让...让你..陪我玩，不...不过看...看你这么有...诚意，谢...谢谢...",@"傲娇什么才....才不会呢!", nil];
    
    tempArr[peace] = peaceSpeech;
    tempArr[happy] = happySpeech;
    tempArr[sad] = sadSpeech;
    
    self.dotSpeech = tempArr;
    
}


//- (NSString *)saySomeThingInThisEmotion:(emotion)aEmotion
//{
//
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
//   return self.dotSpeech[aEmotion][randomNum];
//}
//
//- (UIImage *)imageOfThisEmotion:(emotion)aEmotion
//{
//    return self.dotViewImages[aEmotion];
//}
@end
