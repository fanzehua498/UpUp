//
//  FZHRuntimeViewController.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/25.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//
/**
    runtime(运行时)
    runtime其实是oc的底层实现，也就是oc的幕后工作者
    苹果给提供了一套关于runtime的API
 runtime主要用于在程序运行的过程中，对OC的对象做一系列的操作。
 
 */
#import "FZHRuntimeViewController.h"
#import "NSObject+FZHRunTimeTool.h"
#import "FZHCreateClasOrMethod.h"
#import "FZHPerson.h"
#import "NSURL+FZHUrl.h"
#import <objc/message.h>
#import "FZHPersonKvo.h"
#import "NSObject+KVO.h"
#import "FZHRunLoop.h"
#import "FZH_BaiduMapView.h"
#import "SimpleMapFactory.h"
#import "FZH_MapFzctory.h"
#import "FZHBaiduFactory.h"
//void buy(id objc, SEL _cmd, id obj){
//    NSLog(@"劳资买了%@",obj);
//}

@interface FZHRuntimeViewController ()
{
    NSInteger number;
}
@property (nonatomic, strong) NSMutableDictionary  *persondict;

@property (nonatomic, strong) dispatch_source_t  timer;

@property (nonatomic, strong) FZHPersonKvo  *pKvo;

@property (nonatomic, strong) FZHRunLoop  *runloop;
@end

@implementation FZHRuntimeViewController
- (void)buy:(NSString *)bu
{
    NSLog(@"劳资买了%@",bu);
}

- (void)cgreateFactView
{
//    id<FZH_MapView> mapView = [[FZH_BaiduMapView alloc] initWithFrame:CGRectMake(0, 60, 80, 80)];
//    [self.view addSubview:[mapView GetMapView]];
//    SimpleMapFactory *fac = [[SimpleMapFactory alloc] init];
//    id<FZH_MapView> mapView = [fac getMapView:CGRectMake(0, 60, 80, 80) type:0];
//    [self.view addSubview:[mapView GetMapView]];
    id<FZH_MapFzctory>fac = [[FZHBaiduFactory alloc] init];
    id<FZH_MapView>map = [fac getMapView:CGRectMake(0, 60, 80, 80)];
    [self.view addSubview:[map GetMapView]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    number = 0;
    // Do any additional setup after loading the view.
    [self cgreateFactView];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self runtimeTestMessageSend];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 300, 100, 30);
    [button setTitle:@"存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(100, 400, 100, 30);
    [button1 setTitle:@"取" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(read:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    NSLog(@"%@",NSTemporaryDirectory());

//    NSURL *url = [NSURL fzhURlWithString:@"http://www.baidu.com/中文"];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/zh"];
    NSLog(@"%@",url);

    [self performSelector:@selector(buy:) withObject:@"iphone100"];
//    [self gcdCreateTimer];
    [self kvoself];
}

- (void)kvoself
{
    self.pKvo = [[FZHPersonKvo alloc] init];

    [self.pKvo Fzh_addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"change %@ %@",change,keyPath);

}

/** gcd创建timer */
- (void)gcdCreateTimer
{
    //创建timer
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    //设置timer 事件单位是纳秒 1秒 = 1000000000纳秒
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0);
    //设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });

    //启动timer
    dispatch_resume(self.timer);


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    number += touches.count;

//    [self methodCreatWhenRunning];
    self.pKvo.age = [NSString stringWithFormat:@"%ld",number];
//    dispatch_cancel(self.timer);
//    self.timer = nil;
}
- (void)methodCreatWhenRunning
{
    FZHCreateClasOrMethod *p = [[FZHCreateClasOrMethod alloc] init];
    [p performSelector:@selector(eat:) withObject:@"鸡腿堡"];
//    [p addObserver:nil forKeyPath:nil options:nil context:nil];
}

- (void)save:(id)send
{   //创建一个对象
    FZHPerson *p = [[FZHPerson alloc] init];
    p.name = @"ssss";
    p.age = 20;
    p.sex = @"man";
    p.myAge = 100.0;
    p.myAge1 = 100.0;
    p.mysize = CGSizeMake(100, 100);
//    归档
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"person.person"];

    [NSKeyedArchiver archiveRootObject:p toFile:path];
    self.relatedProperty = @"abc";
//    [[NSMutableDictionary dictionary] setObject:p forKey:@"persion"];
    self.persondict = [NSMutableDictionary dictionary];
    [self.persondict setObject:p forKey:@"persion"];
    [self.runloop addRunLoopObserver];
    __weak FZHRuntimeViewController *weakSelf = self;
    [self.runloop addTask:^{
        [weakSelf read:nil];
    }];
}

- (void)read:(id)send
{
    [self.pKvo Fzh_removeObserver:self forKeyPath:@"age"];
    //解档
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"person.person"];

    FZHPerson * p = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@今年%ld岁",p.name,p.age);
    NSLog(@"%@  %@",self.relatedProperty,self.relatedProperty);
    NSLog(@"%@",[self.persondict objectForKey:@"persion"]);
}
//消息发送机制
- (void)runtimeTestMessageSend
{
//    FZHPerson *p = [[FZHPerson alloc] init];
//    objc_msgSend(p, @selector(run));

//    id cla = objc_msgSend(objc_getClass("FZHPerson"), sel_registerName("alloc"));
//    cla = objc_msgSend(cla, sel_registerName("init"));
//    cla = objc_msgSend(cla, sel_registerName("run"));

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//调用了一个没有实现的对象方法
+(BOOL)resolveInstanceMethod:(SEL)sel
{

    //添加一个未实现方法
    //IMP 方法实现 就是一个函数指针
    //type:返回值类型
    if (sel == @selector(buy:)) {
//        class_addMethod([FZHCreateClasOrMethod class], @selector(buy:), (IMP)buy, "v@:");
        BOOL bo = [NSObject fzh_addMethod:self method:sel methodName:@selector(buy:)];
        return bo;

    }
    return NO;
//    return [super resolveInstanceMethod:sel];
}

-(FZHRunLoop *)runloop
{
    if (!_runloop) {
        _runloop = [[FZHRunLoop alloc] init];
    }
    return _runloop;
}

@end
