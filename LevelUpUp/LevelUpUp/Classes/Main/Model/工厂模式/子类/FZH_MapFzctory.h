//
//  FZH_MapFzctory.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/7.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZH_MapView.h"

//标准协议
@protocol FZH_MapFzctory <NSObject>

- (id<FZH_MapView>)getMapView:(CGRect)frame;

@end
