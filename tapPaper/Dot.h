//
//  dot.h
//  tapPaper
//
//  Created by Vincent_D on 16/1/20.
//  Copyright © 2016年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "TapPaperBeginViewController.h"

typedef enum
{
    peace,
    happy,
    sad
    
}emotion;

@protocol DotDelegate <NSObject>
@required

- (void)setupCache;
- (UIImage *)imageOfThisEmotion:(emotion)aEmotion;
- (NSString *)saySomeThingInThisEmotion:(emotion)aEmotion;

@end

@interface Dot : NSObject <DotDelegate>




@property (nonatomic)NSArray *dotViewImages;
@property (nonatomic)NSArray *dotSpeech;
@property (nonatomic)SystemSoundID peaceId;
@property (nonatomic)SystemSoundID happyId;
@property (nonatomic)SystemSoundID sadId;

@property (nonatomic, weak)id delegate;

@end



