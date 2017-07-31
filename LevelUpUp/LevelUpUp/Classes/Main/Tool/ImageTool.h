//
//  ImageTool.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/4.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageTool : NSObject

@property (nonatomic, strong) NSArray  *appList;

@property (nonatomic, strong) NSOperationQueue  *queue;
@end
/** 
 【备注】SDWebImage中的一些参数：

 *SDWebImageRetryFailed = 1<< 0,   默认选项，失败后重试

 *SDWebImageLowPriority = 1<< 1,    使用低优先级

 *SDWebImageCacheMemoryOnly = 1<< 2,   仅仅使用内存缓存

 *SDWebImageProgressiveDownload = 1<< 3,   显示现在进度

 *SDWebImageRefreshCached = 1<< 4,    刷新缓存

 *SDWebImageContinueInBackground =1 << 5,   后台继续下载图像

 *SDWebImageHandleCookies = 1<< 6,    处理Cookie

 *SDWebImageAllowInvalidSSLCertificates= 1 << 7,    允许无效的SSL验证

 *SDWebImageHighPriority = 1<< 8,     高优先级

 *SDWebImageDelayPlaceholder = 1<< 9     延迟显示占位图片 
 */
