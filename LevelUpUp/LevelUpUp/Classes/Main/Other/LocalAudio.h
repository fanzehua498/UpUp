//
//  LocalAudio.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/18.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface LocalAudio : NSObject
SingletonH(LocalAudio)
/** 开始录音 */
- (void)startRecord;
/** 停止录音 */
- (void)stopRecord;

/** 播放录音 */
- (void)openRecord;

- (void)prepareRecorder;
@end
