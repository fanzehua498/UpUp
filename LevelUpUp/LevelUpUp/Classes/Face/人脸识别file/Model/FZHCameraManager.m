//
//  FZHCameraManager.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/7/14.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHCameraManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
NSString *const FZHThumbnailCreatedNotfication = @"FZHThumbnailCreatedNotfication";

@interface FZHCameraManager  ()<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic, strong) dispatch_queue_t  videoQueue;//捕捉队列
@property (nonatomic, strong) AVCaptureSession  *captureSession;//捕捉会话
@property (nonatomic, weak) AVCaptureDeviceInput *activeVideoInput;//捕捉输入
@property (nonatomic, strong) AVCaptureStillImageOutput  *imageOutput;//捕捉图片输出  AVCapturePhotoOutput
@property (nonatomic, strong) AVCaptureMovieFileOutput  *movieOutput;//捕捉视频输出
@property (nonatomic, strong) AVCapturePhotoOutput  *PhotoOutput;

@property (nonatomic, strong) NSURL  *outputURL;//文件路径
@end

@implementation FZHCameraManager

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
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    self.PhotoOutput = [[AVCapturePhotoOutput alloc] init];
    //设置图片格式
    AVCapturePhotoSettings *setting = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey:AVVideoCodecJPEG}];
    self.PhotoOutput.photoSettingsForSceneMonitoring = setting;

    //输出链接
    if ([self.captureSession canAddOutput:self.imageOutput]) {
        [self.captureSession addOutput:self.imageOutput];
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

#pragma mark - Configuration
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{

    //获取可用的视频设备
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];

    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {

            return device;
        }
    }

    return nil;
}

//活跃设备
- (AVCaptureDevice *)activeCamera {

    return self.activeVideoInput.device;
}
//不活跃设备
- (AVCaptureDevice *)inactiveCamera
{
    AVCaptureDevice *device = nil;
    if (self.cameraCount > 1) {

        if ([self activeCamera].position == AVCaptureDevicePositionBack) {
            device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }else{
            device = [self cameraWithPosition:AVCaptureDevicePositionFront];
        }

    }
    return device;
}

//摄像头个数
-(NSUInteger)cameraCount
{
    return  [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo].count;
}

- (BOOL)switchCameras;
{
    if (![self canSwitchCameras]) {
        return NO;
    }
    //获取当前设备的反向设备
    NSError *error;
    AVCaptureDevice *videoDevice = [self inactiveCamera];

    //
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];

    if (input) {
        //表注原配置变化开始
        [self.captureSession beginConfiguration];

        //将捕捉会话中的，原捕捉设备移除
        [self.captureSession removeInput:self.activeVideoInput];

        //判断新的设备能否加入
        if ([self.captureSession canAddInput:input]) {
            //能够加入
            [self.captureSession addInput:input];
            self.activeVideoInput = input;
        }else{
            //不能加入 使用原设备
            [self.captureSession addInput:self.activeVideoInput];
        }

        //配置完成
        [self.captureSession commitConfiguration];

    }else{
        [self.delegate deviceConfigureFaileWithError:error];

        return NO;
    }

    return YES;
}

- (BOOL)canSwitchCameras
{
    return self.cameraCount > 1;
}


#pragma mark - VideoCapture Method
- (BOOL)isRecording{

    return self.movieOutput.isRecording;
}
- (void)startRecording{

    if (![self isRecording]) {

        //获取当前视频捕捉链接
        AVCaptureConnection *videoConnecting = [self.movieOutput connectionWithMediaType:AVMediaTypeVideo];
        //判断是否支持
        if ([videoConnecting isVideoOrientationSupported]) {
//            videoConnecting.videoOrientation = [self ]
        }

        //是否支持视频稳定
        if ([videoConnecting isVideoStabilizationSupported]) {
            videoConnecting.enablesVideoStabilizationWhenAvailable = YES;
        }

        AVCaptureDevice *device = [self activeCamera];

        if (device.isSmoothAutoFocusEnabled) {

            NSError *error;
            //排它锁 使用时不让其他设备使用
            if ([device lockForConfiguration:&error]) {
                //修改属性
                device.smoothAutoFocusEnabled = YES;
                //解锁
                [device unlockForConfiguration];
            }else{
                NSLog(@"%@",error.localizedDescription);
            }
        }
        //查找写入视频唯一文件系统url
        self.outputURL = [self uniqueURL];

        //
        [self.movieOutput startRecordingToOutputFileURL:self.outputURL recordingDelegate:self];

    }
}
- (void)stopRecording{
    if ([self isRecording]) {
        [self.movieOutput stopRecording];
    }
}

- (CMTime)recordedDuration{

    return self.movieOutput.recordedDuration;
}

//写入统一路径
- (NSURL *)uniqueURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *dirPath = @"";//[fileManager temporaryDirectory];

    if (dirPath) {
        NSString *filePath = [dirPath stringByAppendingPathComponent:@"fzh_movie.mov"];
        return [NSURL URLWithString:filePath];
    }
    return nil;

}


#pragma mark - AVCaptureFileOutputRecordingDelegate

-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    if (error) {
        [self.delegate mediaCaptureFailWithError:error];
    }else{
        [self writeVideoToAssetsLibrary:self.outputURL];
    }
    self.outputURL = nil;
}

- (void)writeVideoToAssetsLibrary:(NSURL *)videoUrl{

    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:videoUrl]) {
        ALAssetsLibraryWriteImageCompletionBlock completionBlock;
        completionBlock = ^(NSURL *assetURL,NSError *error){

            if (error) {
                [self.delegate assetLibraryWriteFailWith:error];
            }else{
                // 缩略图
                [self generateThumbnailForVideoURL:videoUrl];
            }

        };

        //写入系统相册
        [library writeVideoAtPathToSavedPhotosAlbum:videoUrl completionBlock:completionBlock];

    }
}

- (void)generateThumbnailForVideoURL:(NSURL *)videoURL{

    dispatch_async(self.videoQueue, ^{

        AVAsset *asset = [AVAsset assetWithURL:videoURL];
        //1小时26分
        AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
        imageGenerator.maximumSize = CGSizeMake(100, 0);

        imageGenerator.appliesPreferredTrackTransform = YES;
        CGImageRef imageRef = [imageGenerator copyCGImageAtTime:kCMTimeZero actualTime:NULL error:nil];

        UIImage *image = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);

        dispatch_async(dispatch_get_main_queue(), ^{

            //发送通知 1小时 30分；
            [self postThumbnailNotification:image];
        });

    });
}

- (void)postThumbnailNotification:(UIImage *)image
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"postThumbnailNotification" object:image];

    });
}
#pragma mark - image Capture Methods
//拍摄照片

- (void)captureStillImage
{
    //1.建立连接
    AVCaptureConnection *connect = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];

    //2.判断设备方向
    if (connect.isVideoOrientationSupported) {
        //获取方向值
        connect.videoOrientation = [self currentvideoOrientation];
    }

    //3.定义一个代码块
    id handler = ^(CMSampleBufferRef sampleBuffer,NSError *error){

        if (sampleBuffer != NULL) {
            NSData *imageData = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:sampleBuffer previewPhotoSampleBuffer:sampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData];
            //重点 捕捉图片成功后，传递出去
            [self writeImageToAssetsLibrary:image];
        }else{
            NSLog(@"null");
        }
    };

//    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettings];
//    CFStringRef
//    settings.previewPhotoFormat = @{kCVPixelBufferPixelFormatTypeKey:settings.availablePreviewPhotoPixelFormatTypes.firstObject,kCVPixelBufferWidthKey:160,kCVPixelBufferHeightKey:160};
////    settings.previewPhotoFormat = settings.availablePreviewPhotoPixelFormatTypes.firstObject;
//
//    self.PhotoOutput capturePhotoWithSettings:<#(nonnull AVCapturePhotoSettings *)#> delegate:<#(nonnull id<AVCapturePhotoCaptureDelegate>)#>
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:connect completionHandler:handler];
}

- (AVCaptureVideoOrientation )currentvideoOrientation
{
    AVCaptureVideoOrientation orientation ;
    //获取方向
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationPortrait:
            orientation = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeLeft:
            orientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIDeviceOrientationLandscapeRight:
            orientation = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;

        default:
            orientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
    }
    return orientation;
}
//写入系统相册
- (void)writeImageToAssetsLibrary:(UIImage *)image
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

    [library writeImageToSavedPhotosAlbum:image.CGImage orientation:(NSInteger)image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {

        if (!error) {
            [self postThumbnailNotification:image];
        }
    }];

}
@end
