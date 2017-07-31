//
//  BlueToothViewController.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/21.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "BlueToothViewController.h"
#import "FFBlueToothManager.h"
#import "MNWheelView.h"

#import "FZHCircleView.h"
#import "CircularProgressView.h"
@interface BlueToothViewController ()



@end

@implementation BlueToothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    UIButton *tooth = [self createBtn:@"open" buttonType:UIButtonTypeSystem action:@selector(openTooth) target:self forControlEvents:UIControlEventTouchUpInside];
    tooth.frame = CGRectMake(100, 100, 100, 40);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tooth];
     */
    MNWheelView *mnview = [[MNWheelView alloc] init];
    [mnview setFrame:CGRectMake(100, 100, 200, 300)];
    mnview.imageNames = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
//    [self.view addSubview:mnview];
    self.view.backgroundColor = [UIColor whiteColor];
    [self performSelector:@selector(logSomeThing:) withObject:self.ssss afterDelay:1.0];
    int x = 3, y = 10, z = test(x, y);
    NSLog(@"%d %d %d",x,y,z);
    NSLog(@"xxxxx:%d%d", x++, ++z);
    NSLog(@"%d",
          func(2013));


    FZHCircleView *circleView = [[FZHCircleView alloc] initWithFrame:CGRectMake(100, 180, 80, 80)];
    [circleView setImageUrl:@"thereFace"];
//    [self.view addSubview:circleView];

    CircularProgressView *v = [[CircularProgressView alloc] initWithFrame:CGRectMake(80, 180, 60, 60) backColor:[UIColor grayColor] progressColor:[UIColor redColor] lineWidth:5 processValue:0 style:@"two"];
    [self.view addSubview:v];
    v.timeDownLabel.textColor = [UIColor blueColor];
    v.timeDownLabel.frame = CGRectMake(0, 20, 60, 20);
    v.userInteractionEnabled = NO;

    v.layer.borderWidth =2 ;
    v.layer.borderColor =  [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:229.0f/255.0f alpha:1].CGColor;
    v.layer.cornerRadius = 30;
    v.layer.masksToBounds = YES;
}
int test(int x, int y){
    x = x + y;//x = 3 + 10
    return x * y;//z = 13 * 10
}
- (void)logSomeThing:(id)something
{
    NSLog(@"%@",NSStringFromClass([something class]));
}

- (void)openTooth
{
    FFBlueToothManager *manager = [FFBlueToothManager sharedFFBlueToothManager];
    [manager prepareManager];
}

- (UIButton *)createBtn:(NSString *)title buttonType:(UIButtonType )type action:(SEL)action target:(nullable id)target forControlEvents:(UIControlEvents )controlEvents
{
    UIButton *btn = [UIButton buttonWithType:type];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    return btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)setName:(NSString*)str
//{
//    [str retain];
//    [name release];
//    name = str;
//}这些都是class，创建后便是对象，而C语言的基本数据类型int，只是一定字节的内存空间，用于存放数值;NSInteger是基本数据类型，并不是NSNumber的子类，当然也不是NSObject的子类。NSInteger是基本数据类型Int或者Long的别名(NSInteger的定义typedef long NSInteger)，它的区别在于，NSInteger会根据系统是32位还是64位来决定是本身是int还是Long。

-(void)setName:(NSString*)str
{
//    id t=[str copy];
//    [namerelease];
//    name = t;
}

//int main(int argc, const char * argv[]){
//    @autoreleasepool {
//        int x = 3, y = 10, z = test(x, y);
//        NSLog(@"%d%d", x++, ++z); } return 0;
//    }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
int func(int x){
    int countx = 0;
    while(x){
        countx++;
        x = x&(x-1);
    }
    return countx;
}



@end
