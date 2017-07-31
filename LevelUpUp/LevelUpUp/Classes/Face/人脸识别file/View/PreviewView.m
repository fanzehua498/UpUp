//
//  PreviewView.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/14.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "PreviewView.h"
#import "FZHCameraViewController.h"


@implementation PreviewView


+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{

//    1.初始化faceLayers 属性
    self.faceLayers = [NSMutableDictionary dictionary];

    //设置全屏
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //设置overLayer
    self.overlayLayer = [CALayer layer];
    self.overlayLayer.frame = self.bounds;
    //子图层形变 效果
    self.overlayLayer.sublayerTransform = CAtransform3DMakePerspective(1000);
    self.backgroundColor = [UIColor clearColor];
    //
    [self.previewLayer addSublayer:self.overlayLayer];

}

- (CALayer *)makeFaceLayer
{
    CALayer *layer = [CALayer layer];

    layer.borderWidth = 2.0;
    layer.borderColor = [UIColor redColor].CGColor;
    return layer;
}


#pragma mark - 重写Getter setter方法
-(AVCaptureSession *)session
{
    return self.previewLayer.session;
}

-(void)setSession:(AVCaptureSession *)session
{
    self.previewLayer.session = session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer
{
    return (AVCaptureVideoPreviewLayer *)self.layer;
}


#pragma mark - 检测到人脸
- (void)didDetectFaces:(NSArray *)faces
{
    NSArray *transformFaces = [self transfomedFacesFromFace:faces];

    NSMutableArray *lostFace = [self.faceLayers.allKeys mutableCopy];

    for (AVMetadataFaceObject *face in transformFaces) {
        //获取关联的faceId 这是检测人脸的唯一标识
        NSNumber *faceID = @(face.faceID);

        //将对象从lostFace中移除
        [lostFace removeObject:faceID];

        //拿到当前faceID对应的layer
        CALayer *layer = self.faceLayers[faceID];
        if (!layer) {
            //调用makeFaceLayer 创建一个人脸图层
            layer = [self makeFaceLayer];

            //将新的人脸图层添加到 overlayer上
            [self.overlayLayer addSublayer:layer];

            self.faceLayers[faceID] = layer;
        }
        //设置动画
        layer.transform = CATransform3DIdentity;
        layer.frame = face.bounds;
        //有转动
        if (face.hasRollAngle) {
            CATransform3D t = [self transformForRollAngle:face.rollAngle];
            layer.transform = CATransform3DConcat(layer.transform, t);
        }

        if (face.hasYawAngle) {
            CATransform3D t = [self transformForYawAngle:face.yawAngle];
            layer.transform = CATransform3DConcat(layer.transform, t);
        }


        //遍历数组将剩下的人脸移除
        for (NSNumber *faceId in lostFace) {
            CALayer  *layer = self.faceLayers[faceId];
            [layer removeFromSuperlayer];
        }

    }

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
