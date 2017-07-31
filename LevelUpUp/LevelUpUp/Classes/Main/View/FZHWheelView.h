//
//  FZHWheelView.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/16.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^click)(int i);

@interface FZHWheelView : UIView
// imageNames 和images 二选一

//图片数组
@property (nonatomic, weak) NSArray *images;
//图片名数组
@property (nonatomic, weak) NSArray *imageNames;
//单击回调方法
@property (nonatomic, strong) click  click;
@end
