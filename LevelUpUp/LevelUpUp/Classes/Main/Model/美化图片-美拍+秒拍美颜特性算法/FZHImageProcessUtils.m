//
//  FZHImageProcessUtils.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/27.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHImageProcessUtils.h"


#define Mask8(x) ((x) & 0xFF)
#define R(x) (Mask8(x))
#define G(x) (Mask8(x >> 8))
#define B(x) (Mask8(x >> 16))
#define A(x) (Mask8(x >> 24))
#define RGBAMake(r,g,b,a) (Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24)

@implementation FZHImageProcessUtils

//第一种：自己写算法修改像素点，调整亮度，操作内存
+ (UIImage *)imageWithSystem:(UIImage *)imageSrc
{
    /**
    自己写算法
     第一步：获取元素图片
     有两种方案
     第一种
     */

    CGImageRef imageRef = [imageSrc CGImage];
    NSInteger width = CGImageGetWidth(imageRef);
    NSInteger height = CGImageGetHeight(imageRef);

    //第二步：开辟一块内存，用于颜色空间
    //颜色空间有两种（第一种：彩色图片 第二种：灰色图片）
    //美白：彩色图片（美白灰色图片没有任何作用）
    //(准备两本书籍)针对iOS底层技术
    //CGColorSpaceCreateDeviceRGB 彩色
    //CGColorSpaceCreateDeviceGray 灰色
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    //第三步：创建图片的上下文(解析图片信息，同时给我们提供绘制信息)
    //参数一：数据源（普及知识）

    //数据源：图片
    //创建指针作用：指向这样的图片的内存区域，为了我们方便通过指针去操作内存（像素点）
    //图片真实就是像素数组
    //数组指针：指向数组首地址（指向数组第一个元素：第一个像素点）
    //问题：为什么是32位
    //像素点：RGB、ARGB、R、G、B、RG等等...
    //像素点最大内存（最大组合）：ARGB
    //然后：在图像学中A（透明度） R（红色） G（绿色） B（蓝色）
    //A R G B：（四个分量）每一个分量占用多大内存
    //每一个分量占用内存：8位 计算机（每8位=1字节 4 * 8 = 4字节）
    //U
    //图像学中，一般情况像素的取值范围（0～255）
    //-127~128
    UInt32 * inputPixels = calloc(width * height, sizeof(UInt32));

    //参数二 ：图片宽
    //3:图片高
    //4：每一个像素点，每一个分量大小    8
    //5:每一行占用内存大小(每一个像素内存：4个字节 * width)
    //6:颜色空间
    //7:布局摆放（是否需要透明度）
    //字节序（计算机的原理，内存设计）
    CGContextRef contentRef = CGBitmapContextCreate(inputPixels, width, height, 8, width * 4, colorSpace, kCGImageAlphaPremultipliedLast);

    //第四步：根据图片上下文来绘制
    //参数一：图片上下文
//    参数二：绘制区域
//    参数三：源文件
    CGContextDrawImage(contentRef, CGRectMake(0, 0, width, height), imageRef);

    //第五步：美白
    //美白->操作像素点->操作ARGB分量->修改分量值
    //图像学中（三原色：RGB，取值范围：0～255）
    //0~255规律：值愈大愈白
    //总结：修改分量值->增大
    //例如：R = 100 G = 120 B = 150 彩色图片
    //美白操作(+30)
    //R = 130 G = 150 B = 180
    //接下来修改分量值（修改像素点，操作内存）
    //循环遍历像素点（从左到右，自上而下）->外层循环遍历列，内层循环遍历行
    int lumi = 50;//定义亮度
    for (int i = 0; i < height; i ++) {
        for (int j = 0; j < width; j ++) {
//            首先获取像素数组的首地址（指针位移）
            UInt32* currentPixels = inputPixels + (i * width +j);

            UInt32 color = *currentPixels;
            //操作ARGB分量
            //首先获取每一个分量值（位运算 ARGB在内存排版为有顺序，通过位运算获取制定的颜色）
            UInt32 thisR,thisG,thisB,thisA;

            //处理R分量->红色颜色值
            thisR = R(color);
            //修改分量值
            thisR = thisR + lumi;
            //判断是否超出范围(0~255)
            thisR = thisR > 255?255:thisR;
            //G
            thisG = G(color);
            thisG = thisG + lumi;
            thisG = thisG > 255?255:thisG;
            //B
            thisB = B(color);
            thisB = thisB + lumi;
            thisB = thisB > 255?255:thisB;

            //获取透明度
            thisA =A(color);

            //修改像素ARGB值
            *currentPixels = RGBAMake(thisR, thisG, thisB, thisA);
            
        }
    }
    //第六步 ：创建UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(contentRef);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];

    //释放内存
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(contentRef);
    CGImageRelease(newImageRef);
    free(inputPixels);


    return newImage;
}

+(UIImage *)openCVImageWhitening:(UIImage *)imageSrc
{
    //第一步：讲解iOS图片->openCV图片（c/c++图片）

    //注意：需要进行图片类型转换

    //第二步：美白准备（克隆一张图片

    //第三步：开始美白（ps：磨皮效果）


    //将OpenCV图片->ios图片

    return nil;
}

@end
