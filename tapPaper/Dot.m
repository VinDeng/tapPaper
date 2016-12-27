//
//  dot.m
//  tapPaper
//
//  Created by Vincent_D on 16/1/20.
//  Copyright © 2016年 Vincent_D. All rights reserved.
//

#import "Dot.h"

@interface Dot ()

@end

@implementation Dot

- (void)setupCache
{
    [self doesNotRecognizeSelector:_cmd];
}

- (NSString *)saySomeThingInThisEmotion:(emotion)aEmotion
{
    if ( ((TapPaperBeginViewController *)self.delegate).isPlaySound ) {
        
    
        switch (aEmotion) {
            case peace:
                AudioServicesPlaySystemSound(self.peaceId);
                break;
            case happy:
                AudioServicesPlaySystemSound(self.happyId);
                break;
            case sad:
                AudioServicesPlaySystemSound(self.sadId);
                break;
            default:
                break;
        }
        
    }
    NSInteger len = ((NSArray *)self.dotSpeech[aEmotion]).count;
    NSInteger randomNum = arc4random()%len;
    return self.dotSpeech[aEmotion][randomNum];
}

- (UIImage *)imageOfThisEmotion:(emotion)aEmotion
{
    return self.dotViewImages[aEmotion];
}

@end
