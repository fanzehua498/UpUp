//
//  FZHImageProcessUtils.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/27.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FZHImageProcessUtils : NSObject
/** 系统实现 美白 */
+ (UIImage *)imageWithSystem:(UIImage *)imageSrc;
/** openCV */
+ (UIImage *)openCVImageWhitening:(UIImage *)imageSrc;
@end
