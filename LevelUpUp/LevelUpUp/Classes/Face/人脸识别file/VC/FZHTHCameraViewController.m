//
//  FZHTHCameraViewController.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/7/14.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHTHCameraViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface FZHTHCameraViewController ()

@property (nonatomic, strong) dispatch_queue_t  videoQueue;//捕捉队列
@property (nonatomic, strong) AVCaptureSession  *captureSession;//捕捉会话
@property (nonatomic, weak) AVCaptureDeviceInput *activeVideoInput;//捕捉输入
@property (nonatomic, strong) AVCaptureStillImageOutput  *imageOutput;//捕捉图片输出  AVCapturePhotoOutput
@property (nonatomic, strong) AVCaptureMovieFileOutput  *movieOutput;//捕捉视频输出
@property (nonatomic, strong) AVCapturePhotoOutput  *PhotoOutput;

@property (nonatomic, strong) NSURL  *outputURL;//文件路径
@end

@implementation FZHTHCameraViewController


- (BOOL)setupSession:(NSError **)error
{
    //配置捕捉分辨率
    self.captureSession = [[AVCaptureSession alloc] init];

    //设置捕捉分辨率
    self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;//高
    //拿到默认的捕捉设备 后置摄像头
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    //重点：将videoDevice - >AVCaptureDeviceInput
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:error];

    //判断
    if (videoInput) {
        //捕捉会话是否能加入
        if ([self.captureSession canAddInput:videoInput]) {
            [self.captureSession addInput:videoInput];

            self.activeVideoInput = videoInput;
        }
    }else{
        return NO;
    }
    //添加音频输入设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];

    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:error];

    if (audioInput) {
        if ([self.captureSession canAddInput:audioInput]) {
            [self.captureSession addInput:audioInput];
        }

    }else{
        return NO;
    }

    //配置输出
    //输出、视频
//    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    self.PhotoOutput = [[AVCapturePhotoOutput alloc] init];
    //设置图片格式
    AVCapturePhotoSettings *setting = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey:AVVideoCodecJPEG}];
    self.PhotoOutput.photoSettingsForSceneMonitoring = setting;

    //输出链接
    if ([self.captureSession canAddOutput:self.PhotoOutput]) {
        [self.captureSession addOutput:self.PhotoOutput];
    }

    //视频的链接
    self.movieOutput = [[AVCaptureMovieFileOutput alloc] init];

    if ([self.captureSession canAddOutput:self.movieOutput]) {
        [self.captureSession addOutput:self.movieOutput];
    }

    //捕捉队列
    self.videoQueue = dispatch_queue_create("fzh.VideoQueue", NULL);



    return YES;
}

//开始捕捉
- (void)startSession {

    if (![self.captureSession isRunning]) {
        //耗时 放入子线程
        dispatch_async(self.videoQueue, ^{
            [self.captureSession startRunning];
        });

    }
}
//停止捕捉
- (void)stopSession {

    if ([self.captureSession isRunning]) {
        dispatch_async(self.videoQueue, ^{
            [self.captureSession stopRunning];
        });
    }
}

@end
