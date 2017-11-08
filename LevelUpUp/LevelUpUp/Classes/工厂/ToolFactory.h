//
//  ToolFactory.h
//  LevelUpUp
//
//  Created by 范泽华 on 2017/9/30.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToolProtocol.h"

@protocol ToolFactory <NSObject>

- (id<ToolProtocol>)getNeedTool;

@end
