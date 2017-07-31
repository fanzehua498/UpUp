//
//  FFBlueToothManager.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/21.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FFBlueToothManager.h"

@interface FFBlueToothManager ()<CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager  *manager;

@end

@implementation FFBlueToothManager
SingletonM(FFBlueToothManager);

-(void)prepareManager
{
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

-(CBCentralManager *)manager
{
    if (!_manager) {
        _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _manager;
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case 0:
            NSLog(@"CBCentralManagerStateUnknown");
            break;
        case 1:
            NSLog(@"CBCentralManagerStateResetting");
            break;
        case 2:
            NSLog(@"不支持蓝牙");
            break;
        case 3:
            NSLog(@"CBCentralManagerStateUnauthorized");
            break;
        case 4:
            NSLog(@"蓝牙未开启");
            break;
        case 5:
            NSLog(@"蓝牙已开启");
            // 在中心管理者成功开启后再进行一些操作
            // 搜索外设
            [self.manager scanForPeripheralsWithServices:nil // 通过某些服务筛选外设
                                              options:nil]; // dict,条件
            // 搜索成功之后,会调用我们找到外设的代理方法
            // - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI; //找到外设
            break;

        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central // 中心管理者
 didDiscoverPeripheral:(CBPeripheral *)peripheral    // 外设
     advertisementData:(NSDictionary<NSString *,id> *)advertisementData // 外设携带的数据
                  RSSI:(NSNumber *)RSSI // 外设发出的蓝牙信号强度
{
    NSLog(@"%s, line = %d, cetral = %@,peripheral = %@, advertisementData = %@, RSSI = %@", __FUNCTION__, __LINE__, central, peripheral, advertisementData, RSSI);
}

-(void)setNum:(NSNumber *)number
{
    if (_number != number) {
//        [_number release];
//        _number = nil;
//        _number = [number retain];
    }
}

-(NSNumber *)number
{
    return _number;
}

@end
