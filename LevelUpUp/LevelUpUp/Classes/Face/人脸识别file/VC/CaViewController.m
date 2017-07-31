//
//  CaViewController.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/14.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "CaViewController.h"
#import "PreviewView.h"
#import "FZHCameraViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
//#import "FaceDetectionDelegate.h"
@interface CaViewController ()<FaceDetectionDelegate,THCameraControllerDelegate>

@property (nonatomic, strong) PreviewView  *preView;
@property (nonatomic, strong) FZHCameraViewController  *cameraController;

@end

@implementation CaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cameraController = [[FZHCameraViewController alloc] init];
    self.preView = [[PreviewView alloc] initWithFrame:CGRectMake(0, 64, SCREENWidth, SCREENHeight - 64)];
    NSError *error;
    if ([self.cameraController setupSession:&error]) {

        [self.cameraController switchCameras];
        [self.preView setSession:self.cameraController.captureSession];
        self.cameraController.faceDetectionDelegate = self.preView;
        [self.cameraController startSession];
        if ([self.cameraController setupSessionOutputs:nil]) {

        }
    }else{
        NSLog(@"err:%@",error);
    }
    [self.view.layer addSublayer:self.preView.layer];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 64, 100, 60);
    [btn setTitle:@"swichCamera" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(switchCamre:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


//-(PreviewView *)preView
//{
//    if (!_preView) {
//        _preView = [[PreviewView alloc] initWithFrame:CGRectMake(0, 64, SCREENWidth, SCREENHeight - 64)];
//    }
//    return  _preView;
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.cameraController setupSessionOutputs:nil]) {

    }

}
-(void)didDetectFaces:(NSArray *)faces
{

}
- (void)switchCamre:(UIButton *)btn{

    [self.cameraController switchCameras];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
