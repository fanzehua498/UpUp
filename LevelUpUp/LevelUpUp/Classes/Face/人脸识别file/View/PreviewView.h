//
//  PreviewView.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/14.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "FaceDetectionDelegate.h"
@interface PreviewView : UIView

@property (nonatomic, strong) AVCaptureSession  *session;

@end

@interface PreviewView ()<FaceDetectionDelegate>
/** <#type#> */
@property (nonatomic, strong) CALayer  *overlayLayer;
/** <#type#> */
@property (nonatomic, strong) NSMutableDictionary  *faceLayers;
/** 预览view */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer  *previewLayer;

@end
