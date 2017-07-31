//
//  FZHQRCodeViewController.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/15.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PreviewView.h"
#import "FaceDetectionDelegate.h"
@interface FZHQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>//用于处理采集信息的代理
{
    AVCaptureSession * session;//输入输出的中间桥梁
}
/** 预览view */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer  *previewLayer;
@property (nonatomic) id<FaceDetectionDelegate> faceDetectionDelegate;
@end

@implementation FZHQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];

    [session addInput:input];
    [session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeFace];


    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
//    [self.view.layer insertSublayer:layer atIndex:0];

    PreviewView *view = [[PreviewView alloc] initWithFrame:self.view.layer.bounds];
    view.backgroundColor = [UIColor clearColor];
    [view setSession:session];
    [self.view insertSubview:view atIndex:0];
    //开始捕获
    [session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{

    if (metadataObjects.count>0) {
        for (AVMetadataFaceObject *face in metadataObjects) {
            
            NSLog(@"face detected with Id:%li",face.faceID);
            NSLog(@"face bound:%@",NSStringFromCGRect(face.bounds));
        }

        //[session stopRunning];
//        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
//        NSLog(@"%@",metadataObject.stringValue);
        NSLog(@"abc");
    }
    [self.faceDetectionDelegate didDetectFaces:metadataObjects];
}


//将摄像的坐标空间人脸转化为视图空间的对象
- (NSArray *)transfomedFacesFromFace:(NSArray *)faces
{
    NSMutableArray *transformFaces = [NSMutableArray array];

    for (AVMetadataFaceObject *face in faces) {
        //将摄像头的人脸数据->视图上可展示的数据
        //将uikit的坐标 装换为 摄像头的坐标系统
        //图层、镜像、视频重力、方向等因素。ios6.0之前需要自己计算。ios6提供了方法
        AVMetadataObject *transformFace = [self.previewLayer transformedMetadataObjectForMetadataObject:face];
        [transformFaces addObject:transformFace];
    }

    return transformFaces;
    
}


//斜倾角
- (CATransform3D)transformForRollAngle:(CGFloat)rollAngleInDegrees
{
    CGFloat RollAngle = DegreesToRadians(rollAngleInDegrees);
    //随y轴旋转
    return CATransform3DMakeRotation(RollAngle, 0.0f, 0.0f, 1.0f);
}
//偏转角
- (CATransform3D)transformForYawAngle:(CGFloat)yawAngleInDegrees
{
    CGFloat yawAngle = DegreesToRadians(yawAngleInDegrees);
    //随y轴旋转
    CATransform3D yawTransform = CATransform3DMakeRotation(yawAngle, 0.0f, -1.0f, 0.0f);

    return CATransform3DConcat(yawTransform, [self orientationTransform]);
}


#pragma mark - transform
- (CATransform3D)orientationTransform
{
    CGFloat angle = 0.0f;
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIDeviceOrientationLandscapeLeft:
            angle = M_PI / 2.0f;
            break;
        case UIDeviceOrientationLandscapeRight:
            angle = - M_PI/2.0f;
            break;

        default:
            break;
    }

    return CATransform3DMakeRotation(angle, 0.0f, 0.0f, 1.0f);
}


#pragma mark - 设置
static CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}

#pragma mark - 设置一个CATransform3D效果
static CATransform3D CAtransform3DMakePerspective(CGFloat eyePosition){

    //CATransform3D 图层的旋转、缩放、偏移、歪斜、和应用的透视
    //CATransform3DIdentity 是单位矩阵，该矩阵没有缩放、旋转、歪斜和透视。该矩阵应用到涂层上，就是设置默认值
    CATransform3D transform = CATransform3DIdentity;

    //透视效果（远大近小），是通过设置m34 m34 = -1.0/D 默认是0，D越小透视效果越明显
    //D：eyePosition 观察者到投射面的距离
    transform.m34 = -1.0/eyePosition;
    return transform;
}


@end
