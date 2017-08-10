//
//  ViewController.m
//  LevelUpUp
//
//  Created by ydcy-mini on 2017/7/31.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import "ViewController.h"
#import "SolveQuestion.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SolveQuestion *s = [SolveQuestion new];
     
    NSLog(@"%ld",[s whileSum:[NSMutableArray arrayWithObjects:@(1),@(2),@(3),@(4), nil]]);
    [s addArrOne:@[@"1",@"2",@"3"] arrTwo:@[@"7",@"8",@"9",@"4",@"5"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
