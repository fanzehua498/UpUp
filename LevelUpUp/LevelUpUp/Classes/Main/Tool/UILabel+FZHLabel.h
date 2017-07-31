//
//  UILabel+FZHLabel.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/7/5.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FZHLabel)
- (UILabel*(^)(NSString *text,UIFont *font))labelText;
- (UILabel*(^)(CGRect frame))labeFrame;
@end
