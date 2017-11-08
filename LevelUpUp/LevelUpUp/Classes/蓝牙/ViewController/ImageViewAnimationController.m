//
//  ImageViewAnimationController.m
//  LevelUpUp
//
//  Created by 范泽华 on 2017/10/12.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import "ImageViewAnimationController.h"
#import "EmitView.h"
@interface ImageViewAnimationController ()
@property (nonatomic, strong) CIFilter *filter;
@end

@implementation ImageViewAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 200, 200)];
    [self.view addSubview:imageView];
    NSMutableArray *imagArr = [NSMutableArray array];
    
    for (int i = 1; i<7; i++) {
        NSString *fileName = [NSString stringWithFormat:@"pig%d",i];
        UIImage *image = [UIImage imageNamed:fileName];
        [imagArr addObject:image];
    }
    
    [imageView setImage:imagArr[0]];
    //设置图片组
    [imageView setAnimationImages:imagArr];
    //设置10张图片播放的时间
    [imageView setAnimationDuration:3.0f];
    //开始动画
    [imageView startAnimating];
    
//    rand()
    
    
    UIImageView *codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 400, 200, 200)];
    codeImageView.image = [self getQRcode:@"www.baidu.com"];
    [self.view addSubview:codeImageView];
    
    EmitView *vi = [[EmitView alloc] initWithFrame:CGRectMake(100, 200, 205, 205)];
    vi.backgroundColor = [UIColor grayColor];
    [self.view addSubview:vi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UIImage*)getQRcode:(NSString*)content{
    
    _filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    
    NSData *data =  [content dataUsingEncoding:NSUTF8StringEncoding];
    [self.filter setValue:data forKey:@"inputMessage"];
    
    CIImage *ciImage =  self.filter.outputImage;
    ciImage =   [ciImage imageByApplyingTransform:CGAffineTransformMakeScale(10, 10)];
    UIImage *image = [UIImage imageWithCIImage:ciImage];
    
    //     UIImage *CenterIcon2 = [UIImage imageNamed:@"check_pig.png"];//中间填充图片
    //    image =   [self imageWithIcon:CenterIcon2 withQRcodeImg:image];
    
    return image;
}


-(UIImage*)HaveIconQRcode:(NSString*)content CenterIcon:(UIImage*)Icon{
    
    _filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    
    NSData *data =  [content dataUsingEncoding:NSUTF8StringEncoding];
    [self.filter setValue:data forKey:@"inputMessage"];
    
    CIImage *ciImage =  self.filter.outputImage;
    ciImage =   [ciImage imageByApplyingTransform:CGAffineTransformMakeScale(10, 10)];
    UIImage *image = [UIImage imageWithCIImage:ciImage];
    
    
    image =   [self imageWithIcon:Icon withQRcodeImg:image];
    
    return image;
}
- (UIImage *)imageWithIcon:(UIImage *)icon withQRcodeImg:(UIImage*)QRcodeimg
{
    
    CGSize myImgSize= icon.size;
    
//    if (self.size.width>0) {
//        myImgSize.width=self.size.width;
//        myImgSize.height=self.size.height;
//    }else if (myImgSize.width>0){
//        myImgSize= icon.size;
//    }else{
//        
//        myImgSize.width=140;
//        myImgSize.height=140;
//    }
//    myImgSize.width=140;
//    myImgSize.height=140;
//    
//    //开启上下文
//    UIGraphicsBeginImageContext(myImgSize);
//    //画原图
//    [QRcodeimg drawInRect:CGRectMake(0, 0, myImgSize.width, myImgSize.height)];//／／ 需要frame
//    
//    //在中间画用户头像，宽高为20%，正方形
//    CGFloat WH = MIN(myImgSize.width, myImgSize.height) * 0.2;
//    [icon drawInRect:CGRectMake((myImgSize.width - WH) * 0.5, (myImgSize.height - WH) * 0.5, WH, WH)];
    
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
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
