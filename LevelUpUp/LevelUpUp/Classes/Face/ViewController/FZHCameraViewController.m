//
//  FZHCameraViewController.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/13.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "PreviewView.h"
#import "FaceDetectionDelegate.h"
@interface FZHCameraViewController ()<AVCaptureMetadataOutputObjectsDelegate,AVCaptureFileOutputRecordingDelegate>
@property (nonatomic, strong) AVCaptureMetadataOutput  *metadataOutPut;

@property (strong, nonatomic) dispatch_queue_t videoQueue;

@property (weak, nonatomic) AVCaptureDeviceInput *activeVideoInput;
@property (strong, nonatomic) AVCaptureStillImageOutput *imageOutput;
@property (strong, nonatomic) AVCaptureMovieFileOutput *movieOutput;
@property (strong, nonatomic) NSURL *outputURL;

//@property (nonatomic, strong) AVCaptureSession  *session;
@end

@implementation FZHCameraViewController

- (BOOL)setupSession:(NSError *__autoreleasing *)error
{
    //创建捕捉会话  捕捉场景的中心枢纽
    self.captureSession = [[AVCaptureSession alloc] init];

    //设置分辨率
    self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;

    //拿到默认的视频捕捉设备 ios系统默认返回后置摄像头
    AVCaptureDevice *videoDevoce = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    //videoDevice 必须封装到AVCaptureDeviceInput 对象
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevoce error:error];

    //判断videoInput 是否有效
    if (videoInput) {

        //canAddInput 判断能否被加入到会话中
        if ([self.captureSession canAddInput:videoInput]) {
            //将VideoInput 设置为捕捉会话的 输入设备
            [self.captureSession addInput:videoInput];

            self.activeVideoInput = videoInput;
        }else{

            return NO;
        }

    }
    //建立图片输出连接
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    //配置输出照片格式.jpeg
    self.imageOutput.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};

    //输出连接，判断是否可用
    if ([self.captureSession canAddOutput:self.imageOutput]) {
        [self.captureSession addOutput:self.imageOutput];
    }

    //建立输出连接
    self.movieOutput = [[AVCaptureMovieFileOutput alloc] init];
    //判断输出视频连接 是否可用
    if ([self.captureSession canAddOutput:self.movieOutput]) {
        [self.captureSession addOutput:self.movieOutput];
    }

    self.videoQueue = dispatch_queue_create("fzh.VideoQueue", NULL);
    return YES;
}

-(void)startSession
{
    if (![self.captureSession isRunning]) {
        //使用同步调用会损耗时间，用异步的方式处理
        dispatch_async(self.videoQueue, ^{
            [self.captureSession startRunning];
        });
    }
}

-(void)stopSession
{
    if ([self.captureSession isRunning]) {
        //使用同步调用会损耗时间，用异步的方式处理
        dispatch_async(self.videoQueue, ^{
            [self.captureSession stopRunning];
        });
    }
}


#pragma mark - DEvice Configuration

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition )position
{
    //1,获取可用的视频设备
    NSArray *device = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];

    //遍历可用设备
    for (AVCaptureDevice *de in device) {
        if (de.position == position) {
            return de;
        }
    }
    return nil;
}

//激活的摄像头
- (AVCaptureDevice *)activeCamera
{
    return self.activeVideoInput.device;
}
//拿到未激活的摄像头
- (AVCaptureDevice *)inactiveCamera
{
    //通过查找当前激活的摄像头的反向摄像获得，如果只有1个摄像头，则返回nil
    AVCaptureDevice *device = nil;
    if (self.cameraCount > 1) {

        if (self.activeVideoInput.device.position == AVCaptureDevicePositionBack) {
            device = [self cameraWithPosition:AVCaptureDevicePositionFront];
        }else{
            device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }

    }
    return device;
}

//是否可切换摄像头
-(BOOL)canSwitchCameras
{
    return self.cameraCount > 1;
}

-(NSUInteger)cameraCount
{
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
}
//切换摄像头
-(BOOL)switchCameras
{
    if (![self canSwitchCameras]) {
        return  NO;
    }

    //1,device
    AVCaptureDevice *videoDevice = [self inactiveCamera];

    NSError *err;
    //2,将输入设备封装成AVCaptureDeviceInput
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&err];

    if (videoInput) {

        //标注原配置变化开始
        [self.captureSession beginConfiguration];
        //将捕捉会话中，原本捕捉输入设备移除
        [self.captureSession removeInput:self.activeVideoInput];

        //判断新的设备能否加入
        if ([self.captureSession canAddInput:videoInput]) {
            [self.captureSession addInput:videoInput];

            //更新活动输入标记
            self.activeVideoInput = videoInput;
        }else{
            //若不成功，重🆕加入原input
            [self.captureSession addInput:self.activeVideoInput];
        }
        //配置完成后,会分批将所有的变更整合在一起
        [self.captureSession commitConfiguration];

    }else{
        [self.delegate deviceConfigurationFailedWithError:err];
    }
    return YES;
}

- (BOOL)setupSessionOutputs:(NSError *)error
{
    self.metadataOutPut = [[AVCaptureMetadataOutput alloc] init];

    if ([self.captureSession canAddOutput:self.metadataOutPut] ) {

//        1.为捕捉会话添加设备
        [self.captureSession addOutput:self.metadataOutPut];
//        NSLog(@"%@",self.metadataOutPut.availableMetadataObjectTypes);
        //2获取人脸属性
        NSArray *metaObjectTypes = @[AVMetadataObjectTypeFace];
        //3限制检查到的元数据 只有人脸数据

        self.metadataOutPut.metadataObjectTypes = metaObjectTypes;
        //4 创建主队列
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        //5 设置代理 和 队列
        [self.metadataOutPut setMetadataObjectsDelegate:self queue:mainQueue];


      
        //开始捕获
        [self.captureSession startRunning];
        return YES;
    }else{
        if (error) {
            NSLog(@"%@",error);
        }
        return NO;
    }

}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    for (AVMetadataFaceObject *face in metadataObjects) {

        NSLog(@"face detected with Id:%li",face.faceID);
        NSLog(@"face bound:%@",NSStringFromCGRect(face.bounds));
    }
    //将原数组传递给 PreviewView.m 将原数据转换为layer
    [self.faceDetectionDelegate didDetectFaces:metadataObjects];
}

@end
