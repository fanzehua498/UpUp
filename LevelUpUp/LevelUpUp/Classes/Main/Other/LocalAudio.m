//
//  LocalAudio.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/18.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalAudio.h"
#import <AVFoundation/AVFoundation.h>

#define kPath [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/recordfile.caf"]

@interface LocalAudio ()<AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder  *recorder;

@property (nonatomic, strong) AVAudioPlayer  *player;
@end


@implementation LocalAudio
SingletonM(LocalAudio)




- (void)prepareRecorder
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryRecord error:nil];

    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    //设置录音格式    AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率（HZ）如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数 1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性的采样位数 8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];

    //录音路径
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/recordfile.caf"];
    NSLog(@"kpath:%@",kPath);
    NSURL *url = [NSURL URLWithString:path];
    NSError *err;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err];
    if (err) {
        NSLog(@"%@",err);
    }
    
    self.recorder.delegate = self;
    [self.recorder prepareToRecord];
    [self.recorder record];
    
   

}

-(void)startRecord
{
    [self prepareRecorder];
}

-(void)stopRecord
{
    [_recorder stop];
}

-(void)openRecord
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSURL *url = [NSURL URLWithString:kPath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_player prepareToPlay];
    [_player play];
}

#pragma mark - AVAudioRecorderDelegate
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (flag) {
//        NSLog(@"%f",_recorder.deviceCurrentTime);
//        //录音完成写入目录
//        NSURL *url = [NSURL URLWithString:kPath];
//        NSData *recordData = [NSData dataWithContentsOfURL:url];
//        BOOL write = [recordData writeToFile:kPath atomically:YES];
//        if (write) {
//            NSLog(@"success");
//        }else{
//            NSLog(@"fail");
//        }
        //上传
        
    }
    
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    if (error) {
        NSLog(@"boom");
    }
}

- (void)switchWavToAmr
{
    
}
@end
