//
//  FzhPlayerViewController.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/5.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FzhPlayerViewController.h"
#import "FZH_ScrollView.h"
@interface FzhPlayerViewController ()
{
    FZH_ScrollView *_v;
}
@end

@implementation FzhPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _v = [[FZH_ScrollView alloc] initWithFrame:CGRectMake(0, 100, SCREENWidth, 200)];
    _v.backgroundColor = [UIColor blueColor];
    _v.isScroll = YES;
    _v.autoScrollDeley = 3;
//    _v.imageArr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    _v.imageArr = @[@"second.jpeg",@"third.jpeg",@"fourth.jpeg",@"fifth.jpeg",@"sixth.jpeg",@"seventh.jpeg",@"eighth.jpg"];
    [self.view addSubview:_v];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [_v removeTimer];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
