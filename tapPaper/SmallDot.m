
//
//  bigDot.m
//  tapPaper
//
//  Created by Vincent_D on 16/1/20.
//  Copyright © 2016年 Vincent_D. All rights reserved.
//

#import "SmallDot.h"

@implementation SmallDot

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
    path = [[NSBundle mainBundle] pathForResource:@"smallDotNormal" ofType:@"jpg"];
    UIImage *peaceImg = [[UIImage alloc] initWithContentsOfFile:path];
    
    path = [[NSBundle mainBundle] pathForResource:@"smallDotHappy" ofType:@"jpg"];
    
    UIImage * happyImg= [[UIImage alloc] initWithContentsOfFile:path];
    
    path = [[NSBundle mainBundle] pathForResource:@"smallDotSad" ofType:@"jpg"];
    
    UIImage *sadImg = [[UIImage alloc] initWithContentsOfFile:path];
    
    
    
    self.dotViewImages = [NSArray arrayWithObjects:peaceImg,happyImg,sadImg, nil];
    
    ////载入音频文件到内存中
    path = [[NSBundle mainBundle] pathForResource:@"small_dot_normal" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    SystemSoundID tempId = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(tempId));
    self.peaceId = tempId;
    tempId = 0;
    
    path = [[NSBundle mainBundle] pathForResource:@"small_dot_happy" ofType:@"wav"];
    url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(tempId));
    self.happyId = tempId;
    tempId = 0;
    
    
    path = [[NSBundle mainBundle] pathForResource:@"small_dot_sad" ofType:@"wav"];
    url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(tempId));
    self.sadId = tempId;
    tempId = 0;
    
    ///载入文本文件到内存中
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    
    NSArray *peaceSpeech = [NSArray arrayWithObjects:@"摸摸，好舒服",@"小点点问你，你是我的主人吗",@"欺负我的话，我可会叫姐姐收拾你的哦~", nil];
    NSArray *happySpeech = [NSArray arrayWithObjects:@"快来陪点点玩吧",@"嘻嘻，记得平时有空的时候陪一下我哦",@"最喜欢你的了", nil];
    NSArray *sadSpeech = [NSArray arrayWithObjects:@"呜呜呜...",@"你喜欢点点，你不喜欢点点，你喜欢点点..",@"最近都吃不饱,快来点一下广告吧",@"姐姐玩得比我好，不开心", @"刚才看到一只全身黑色的点点，好可怕..",nil];
    
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
