//
//  CardViewController.m
//  LevelUpUp
//
//  Created by 范泽华 on 2017/10/9.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import "CardViewController.h"
#import "ScollerCard.h"
#import "CustumCardLayout.h"
#import "CustumCardCell.h"

#define  screen_width  [UIScreen mainScreen].bounds.size.width
#define screen_height  [UIScreen mainScreen].bounds.size.height

@interface CardViewController ()
@property(nonatomic,strong) UICollectionView *collerctionView;
@property(nonatomic,strong) NSArray *models;
@end

@implementation CardViewController
- (CGFloat)fillScreenHeight:(CGFloat)height
{
    return height * screen_height / 375.0;
}

- (CGFloat)fillScrennWidth:(CGFloat)width
{
    return width * screen_width / 375.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    ScollerCard *card = [[ScollerCard alloc] initWithFrame:CGRectMake(0, 64, 375, 500)];
    self.models = @[@"C语言程序与设计", @"Swift入门与实践", @"教你怎么不生气", @"沉默的愤怒", @"颈椎病康复指南", @"腰椎间盘突出日常护理", @"心脏病的预防与防治", @"高血压降压宝典", @"精神病症状学", @"活着"];
//    card.selectedIndex = 3;
//    [card show];
    [self.view addSubview:card];
    
    
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

@end
