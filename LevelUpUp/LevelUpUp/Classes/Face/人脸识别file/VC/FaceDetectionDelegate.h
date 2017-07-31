//
//  FaceDetectionDelegate.h
//  香香香香鸡啊
//
//  Created by ydcy-mini on 2017/6/29.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FaceDetectionDelegate <NSObject>

- (void)didDetectFaces:(NSArray *)faces;

@end
