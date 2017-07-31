//
//  FZHTHCameraViewController.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/7/14.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>

extern NSString *const FZHThumbnailCreatedNotfication;

@protocol FZHCameraControllerDelegate <NSObject>
/** 设备错误 */
- (void)deviceConfigureFaileWithError:(NSError *)error;
/** 媒体错误 */
- (void)mediaCaptureFailWithError:(NSError *)error;
/** 写入相册错误 */
- (void)assetLibraryWriteFailWith:(NSError *)error;
@end


@interface FZHTHCameraViewController : NSObject

@property (nonatomic, weak) id<FZHCameraControllerDelegate> delegate;
@property (nonatomic, strong,readonly) AVCaptureSession  *captureSession;//捕捉会话

/** 用于配置捕捉会话 */
- (BOOL)setupSession:(NSError **)error;
/** <#type#> */
- (void)startSession;
/** <#type#> */
- (void)stopSession;

/** 切换摄像头 */
- (BOOL)switchCameras;
- (BOOL)canSwitchCameras;

@property (nonatomic,readonly) NSUInteger cameraCount;
@property (nonatomic,readonly) BOOL cameraHasTorch;
@property (nonatomic,readonly) BOOL cameraHasFlash;
@property (nonatomic,readonly) BOOL cameraSupportsTapToFocus;//聚焦
@property (nonatomic,readonly) BOOL cameraSupportsTapToExpose;//曝光
@property (nonatomic) AVCaptureTorchMode torchMode;//手电筒模式
@property (nonatomic) AVCaptureFlashMode flashMode;//闪光灯模式

/** 聚焦 曝光 重新聚焦&曝光 */
- (void)focusAtPoint:(CGPoint)point;
- (void)exposeAtPoint:(CGPoint)point;
- (void)resetFocusAndExposeModes;


/** 拍照 */
- (void)captureStillImage;

/** 录制视频 */
- (void)startRecording;
- (void)stopRecording;
- (BOOL)isRecording;
- (CMTime)recordedDuration;
@end
