//
//  FaceViewController.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/10.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FaceViewController.h"

@interface FaceViewController ()
@property (nonatomic, strong) UIImageView *imageview;
@end

@implementation FaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"LaunchImage.jpeg"];
//UIImage *image = [UIImage imageNamed:@"thereFace.png"];
    self.imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageview.image = image;
    [self.view addSubview:self.imageview];
    [self faceDetectWithImage:image];

//    CIImage *ciIma = [CIImage imageWithCGImage:imageview.image.CGImage];
//    NSDictionary *dic = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
//
//    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:dic];
//
//    NSArray *ar = [detector featuresInImage:ciIma];
//    // 得到图片的尺寸
//    CGSize inputsize = [ciIma extent].size;
//    //将image沿y轴对称
//    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, -1);
//
//
//    for (CIFaceFeature *f in ar) {
//        CGRect aRect = f.bounds;
//        NSLog(@"%f, %f, %f, %f", aRect.origin.x, aRect.origin.y, aRect.size.width, aRect.size.height);
//
//        //眼睛和嘴的位置
//        if(f.hasLeftEyePosition) NSLog(@"Left eye %g %g\n", f.leftEyePosition.x, f.leftEyePosition.y);
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(f.leftEyePosition.x, f.leftEyePosition.y, 5, 5)];
//        label.backgroundColor = [UIColor redColor];
//        [self.imageview addSubview:label];
//
//        if(f.hasRightEyePosition) NSLog(@"Right eye %g %g\n", f.rightEyePosition.x, f.rightEyePosition.y);
//        if(f.hasMouthPosition) NSLog(@"Mouth %g %g\n", f.mouthPosition.x, f.mouthPosition.y);
//    }
}


#pragma mark - 识别人脸
- (void)faceDetectWithImage:(UIImage *)image {

    for (UIView *view in self.imageview.subviews) {
        [view removeFromSuperview];
    }

    // 图像识别能力：可以在CIDetectorAccuracyHigh(较强的处理能力)与CIDetectorAccuracyLow(较弱的处理能力)中选择，因为想让准确度高一些在这里选择CIDetectorAccuracyHigh
    NSDictionary *opts = [NSDictionary dictionaryWithObject:
                          CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    // 将图像转换为CIImage
    CIImage *faceImage = [CIImage imageWithCGImage:image.CGImage];
    CIDetector *faceDetector=[CIDetector detectorOfType:CIDetectorTypeFace context:nil options:opts];
    // 识别出人脸数组
    NSArray *features = [faceDetector featuresInImage:faceImage];
    // 得到图片的尺寸
    CGSize inputImageSize = [faceImage extent].size;
    //将image沿y轴对称
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, -1);
    //将图片上移
    transform = CGAffineTransformTranslate(transform, 0, -inputImageSize.height);

    // 取出所有人脸
    for (CIFaceFeature *faceFeature in features){
        //获取人脸的frame
        CGRect faceViewBounds = CGRectApplyAffineTransform(faceFeature.bounds, transform);
        CGSize viewSize = self.imageview.bounds.size;
        CGFloat scale = MIN(viewSize.width / inputImageSize.width,
                            viewSize.height / inputImageSize.height);
        CGFloat offsetX = (viewSize.width - inputImageSize.width * scale) / 2;
        CGFloat offsetY = (viewSize.height - inputImageSize.height * scale) / 2;
        // 缩放
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(viewSize.width / inputImageSize.width, viewSize.height / inputImageSize.height);
        // 修正
        faceViewBounds = CGRectApplyAffineTransform(faceViewBounds,scaleTransform);
        faceViewBounds.origin.x += 0;
        faceViewBounds.origin.y += 0;

        //描绘人脸区域
        UIView* faceView = [[UIView alloc] initWithFrame:faceViewBounds];
        faceView.layer.borderWidth = 2;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        [self.imageview addSubview:faceView];

        // 判断是否有左眼位置
        if(faceFeature.hasLeftEyePosition){

            

            CGPoint leftpoint = CGPointApplyAffineTransform(faceFeature.leftEyePosition, transform);
            leftpoint.x *=viewSize.width / inputImageSize.width;
            leftpoint.y *=viewSize.height / inputImageSize.height;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftpoint.x, leftpoint.y, 5, 5)];
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(faceViewBounds.origin.x, leftpoint.y, faceViewBounds.size.width, 5)];
                    label.backgroundColor = [UIColor redColor];
                    [self.imageview addSubview:label];
        }
        // 判断是否有右眼位置
        if(faceFeature.hasRightEyePosition){}
        // 判断是否有嘴位置
        if(faceFeature.hasMouthPosition){
//             CGPoint leftpoint = CGPointApplyAffineTransform(faceFeature.mouthPosition, transform);
//            leftpoint.x *=scale;
//            leftpoint.y *=scale;
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftpoint.x, leftpoint.y, 5, 5)];
//
//            label.backgroundColor = [UIColor orangeColor];
//            [self.imageview addSubview:label];

        }
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
