//
//  FZHBaiduFactory.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/7.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHBaiduFactory.h"
#import "FZH_BaiduMapView.h"
@implementation FZHBaiduFactory
-(id<FZH_MapView>)getMapView:(CGRect)frame
{
    return [[FZH_BaiduMapView alloc] initWithFrame:frame];
}
@end
