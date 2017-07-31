//
//  LearnTableViewController.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/10.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "LearnTableViewController.h"
#import "FaceViewController.h"
#import "FZHAudioViewController.h"
#import "FZHRuntimeViewController.h"
#import "BlueToothViewController.h"
#import "FzhPlayerViewController.h"
#import "CaViewController.h"
#import "FZHQRCodeViewController.h"
#import "FZHMyManagerCameraVC.h"
#import "FZHAppsVC.h"
#import <WebKit/WebKit.h>
@interface LearnTableViewController ()

@property (nonatomic, strong) NSArray  *rowArr;

@property (nonatomic, strong) UIImageView  *headerImageView;


@property (nonatomic, strong) UIView  *backView;
@property (nonatomic, strong) UIImageView  *tableViewheadImageView;
@end

#define ktopViewH 350

@implementation LearnTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    WKWebView 
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Level-Up";
    self.tableView.tableFooterView = [[UIView alloc] init];

//  这里为什么不直接将headerImageView作为titleView呢？因为titleView会自动被系统给设置大小了，而我们的头像是固定大小的，可以可自由调整的，因此我们只能作为一个单独的控件放在titleView上。
    UIView *titleView = [[UIView alloc]init];
    self.navigationItem.titleView = titleView;

    self.headerImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LaunchImage.jpeg"]];
    self.headerImageView.layer.cornerRadius = 35;
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.frame = CGRectMake(0, 0, 70, 70);
    // 这一句非常重要，保证用户头像水平居中
    self.headerImageView.center = CGPointMake(titleView.center.x, 0);
    [titleView addSubview:self.headerImageView];

    // 设置内边距(让cell往下移动一段距离)
    self.tableView.contentInset = UIEdgeInsetsMake(ktopViewH * 0.5 , 0, 0, 0);
    [self.backView addSubview:self.tableViewheadImageView];
//    self.tableView.tableHeaderView = self.tableViewheadImageView;
    [self.tableView insertSubview:self.tableViewheadImageView atIndex:0];
    NSLog(@"%@",NSStringFromCGRect(self.tableView.frame));



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImageView *)tableViewheadImageView
{
    if (!_tableViewheadImageView) {
        _tableViewheadImageView = [[UIImageView alloc] init];
        _tableViewheadImageView.image = [UIImage imageNamed:@"biaoqingdi"];
        //使用contentMode设置图片拉伸效果
        _tableViewheadImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _tableViewheadImageView.clipsToBounds = YES;
        _tableViewheadImageView.frame = CGRectMake(0, - ktopViewH, SCREENWidth, ktopViewH);
    }
    return _tableViewheadImageView;
}

-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWidth, 44)];
//        _backView.backgroundColor = [UIColor redColor];

        _backView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"LaunchImage.jpeg"].CGImage);
    }
    return _backView;
}

-(NSArray *)rowArr
{
    if (!_rowArr) {

        _rowArr = @[@"Face",@"Map",@"Audio",@"blueTooth",@"runtime",@"FZHCameraViewController",@"FZHQRCodeViewController",@"FZHMyManagerCameraVC",@"FZHAppsVC"];
    }
    return _rowArr;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.rowArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId ];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        [cell addSubview:self.backView];
    }
    cell.selectedBackgroundView = self.backView;
//    [cell setValue:self.backView forKey:@"backgroundView"];
//    self.backView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"LaunchImage.jpeg"].CGImage);


//    cell.detailTextLabel.text = self.rowArr[indexPath.row];
    cell.textLabel.text = self.rowArr[indexPath.row];

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FaceViewController *vc = [[FaceViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        FZHAudioViewController *vc = [[FZHAudioViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    if (indexPath.row == 1) {
        //修改icon的Number
//        NSInteger valueN = [UIApplication sharedApplication].applicationIconBadgeNumber;
//        NSLog(@"%@ %ld",self,valueN);
//        valueN += indexPath.row;
//        NSNumber *number = [NSNumber numberWithInteger:valueN];
//        USER_DEFAULTS_SET(badgNuber, number);
//        [[NSNotificationCenter defaultCenter] postNotificationName:badgNuber object:number];
        FzhPlayerViewController *vc = [[FzhPlayerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

        
    }if (indexPath.row == 3) {
        BlueToothViewController *vc = [[BlueToothViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    if (indexPath.row == 4) {
        FZHRuntimeViewController *vc = [[FZHRuntimeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    if (indexPath.row == 5) {
        CaViewController *vc = [[CaViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    if (indexPath.row == 6) {
        FZHQRCodeViewController *vc = [[FZHQRCodeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }if (indexPath.row == 7) {
        FZHMyManagerCameraVC *vc = [[FZHMyManagerCameraVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }if (indexPath.row == 8) {
        FZHAppsVC *vc = [[FZHAppsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

    //FZHMyManagerCameraVC
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
//    self.navigationController.navigationBar.alpha = 0.2;
    CGFloat scale = 1.0;
    // 放大
    if (offsetY < 0) {
        // 允许下拉放大的最大距离为300
        // 1.5是放大的最大倍数，当达到最大时，大小为：1.5 * 70 = 105
        // 这个值可以自由调整
        scale = MIN(1.5, 1 - offsetY / 300);
    } else if (offsetY > 0) { // 缩小
        // 允许向上超过导航条缩小的最大距离为300
        // 为了防止缩小过度，给一个最小值为0.45，其中0.45 = 31.5 / 70.0，表示
        // 头像最小是31.5像素
        scale = MAX(0.45, 1 - offsetY / 300);
    }

    self.headerImageView.transform = CGAffineTransformMakeScale(scale, scale);

    // 保证缩放后y坐标不变
    CGRect frame = self.headerImageView.frame;
    frame.origin.y = -self.headerImageView.layer.cornerRadius / 2;
    self.headerImageView.frame = frame;



    CGFloat headOffSet = -(ktopViewH * 0.5) - scrollView.contentOffset.y;
    if (headOffSet > 0) {
//        self.tableViewheadImageView.transform = CGAffineTransformMakeScale(1, 1);
        CGRect frame = self.tableViewheadImageView.frame;
        // 0.5决定图片变大的速度，值越大，速度越快
        frame.size.height = ktopViewH + headOffSet * 0.5;
        self.tableViewheadImageView.frame = frame;
        NSLog(@"frame:%@",NSStringFromCGRect(frame));
    }else{
//        self.tableViewheadImageView.transform = CGAffineTransformMakeScale(scale, scale);
        return;

    }
    NSLog(@"headOffSet:%lf",headOffSet);

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
