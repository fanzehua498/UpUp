//
//  FZHCameraViewController.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/13.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "FaceDetectionDelegate.h"
//@protocol FaceDetectionDelegate <NSObject>                             // CC_1
////- (void)deviceConfigurationFailedWithError:(NSError *)error;
////- (void)mediaCaptureFailedWithError:(NSError *)error;
////- (void)assetLibraryWriteFailedWithError:(NSError *)error;
//- (void)didDetectFaces:(NSArray *)faces;
//@end
@protocol THCameraControllerDelegate <NSObject>                             // CC_1
- (void)deviceConfigurationFailedWithError:(NSError *)error;
- (void)mediaCaptureFailedWithError:(NSError *)error;
- (void)assetLibraryWriteFailedWithError:(NSError *)error;
- (void)didDetectFaces:(NSArray *)faces;
@end

@interface FZHCameraViewController : UIViewController

//@property (nonatomic, copy) dispatch_queue_t videoQueue;
//
///** 视频输出 */
//@property (nonatomic, strong) AVCaptureMovieFileOutput  *movieOutput;
///** 图片输出 */
//@property (nonatomic, strong) AVCaptureStillImageOutput  *imageOutput;
///** 设备输入 */
//@property (nonatomic, strong) AVCaptureDeviceInput *activeVideoInput ;
//
//@property (nonatomic, strong) AVCaptureSession  *captureSession;
@property (nonatomic, readonly) NSUInteger cameraCount;
@property (nonatomic, readonly) BOOL cameraHasTorch;
@property (nonatomic, readonly) BOOL cameraHasFlash;
@property (nonatomic, readonly) BOOL cameraSupportsTapToFocus;
@property (nonatomic, readonly) BOOL cameraSupportsTapToExpose;
@property (nonatomic) AVCaptureTorchMode torchMode;
@property (nonatomic) AVCaptureFlashMode flashMode;

@property (strong, nonatomic) AVCaptureSession *captureSession;

@property (nonatomic, weak) id<THCameraControllerDelegate> delegate;

@property (nonatomic) id<FaceDetectionDelegate> faceDetectionDelegate;

- (BOOL)setupSessionOutputs:(NSError *)error;

// Session Configuration
- (BOOL)setupSession:(NSError **)error;
- (void)startSession;
- (void)stopSession;

// Camera Device Support                                                    // 切换摄像头
- (BOOL)switchCameras;
- (BOOL)canSwitchCameras;

//// Still Image Capture
//- (void)captureStillImage;
//
//// Video Recording
//- (void)startRecording;
//- (void)stopRecording;
//- (BOOL)isRecording;
//- (CMTime)recordedDuration;
@end
