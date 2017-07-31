//
//  SimpleMapFactory.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/7.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZH_MapView.h"
@interface SimpleMapFactory : NSObject
- (id<FZH_MapView>)getMapView:(CGRect)frame type:(int)type;
@end
