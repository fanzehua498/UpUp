//
//  FZHCircleView.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/22.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZHCircleView : UIView
// 设置图片
- (void)setImageUrl:(NSString *)url;
//更新进度
- (void)updateProgressWithNumber:(NSInteger)progress;
@end
