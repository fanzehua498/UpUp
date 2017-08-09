

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
