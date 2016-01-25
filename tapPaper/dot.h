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
#import "tapPaperBeginViewController.h"

typedef enum
{
    peace,
    happy,
    sad
    
}emotion;

@protocol dotDelegate <NSObject>
@required

- (void)setupCache;
- (UIImage *)imageOfThisEmotion:(emotion)aEmotion;
- (NSString *)saySomeThingInThisEmotion:(emotion)aEmotion;

@end

@interface dot : NSObject <dotDelegate>




@property (nonatomic)NSArray *dotViewImages;
@property (nonatomic)NSArray *dotSpeech;
@property (nonatomic)SystemSoundID peaceId;
@property (nonatomic)SystemSoundID happyId;
@property (nonatomic)SystemSoundID sadId;

@property (nonatomic, weak)id delegate;

@end



