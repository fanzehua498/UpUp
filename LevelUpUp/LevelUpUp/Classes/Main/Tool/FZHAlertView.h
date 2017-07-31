//
//  FZHAlertView.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/7/5.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FZHAlertView;
typedef FZHAlertView * (^AlertBlock)(NSString *text);

@interface FZHAlertView : UITextField

- (AlertBlock)begin;
- (FZHAlertView *(^)())show:(UIColor *)color;
- (FZHAlertView *(^)())eat:(NSString *)text;
- (FZHAlertView *(^)())run:(NSString *)text;
@end
