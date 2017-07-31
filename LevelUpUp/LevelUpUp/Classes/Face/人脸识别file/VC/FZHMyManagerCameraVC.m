//
//  FZHMyManagerCameraVC.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/7/17.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHMyManagerCameraVC.h"
#import "FZHCameraManager.h"
#import "PreviewView.h"
@interface FZHMyManagerCameraVC ()
@property (nonatomic, strong) FZHCameraManager  *manager;

@property (nonatomic, strong) PreviewView  *preView;
@end

@implementation FZHMyManagerCameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.manager = [[FZHCameraManager alloc] init];
    self.preView = [[PreviewView alloc] initWithFrame:CGRectMake(0, 64, SCREENWidth, SCREENHeight - 64)];
    NSError *err;
    BOOL succ = [self.manager setupSession:&err];
    if (succ) {
        [self.manager startSession];
        [self.preView setSession:self.manager.captureSession];
//        if (self.manager set) {
//            <#statements#>
//        }
    }else{
        NSLog(@"%@",err.localizedDescription);
    }
    [self.view.layer addSublayer:self.preView.layer];
}

- (void)UICreate
{
    UIButton *close = [UIButton buttonWithType:UIButtonTypeSystem];
    close.frame = CGRectMake(0, 0, 40, 40);
    [close setTitle:@"关闭" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeSession:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
}

- (void)closeSession:(UIButton *)sender
{
    [self.manager stopSession];
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
