//
//  Const.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/20.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>

// 偏好设置设置
#define USER_DEFAULTS_SET(key, value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize]
// 偏好设置获取
#define USER_DEFAULTS_GET(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
// 偏好设置移除
#define USER_DEFAULTS_REMOVE(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize]

#define SCREENWidth [UIScreen mainScreen].bounds.size.width
#define SCREENHeight [UIScreen mainScreen].bounds.size.height

#define kThemColor [UIColor colorWithHexString:@"#c6aa69"]

extern NSNumber *kUID;

extern NSString *const badgNuber;
