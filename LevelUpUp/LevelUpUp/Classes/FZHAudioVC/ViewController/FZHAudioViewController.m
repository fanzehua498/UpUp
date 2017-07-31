//
//  FZHAudioViewController.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/19.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHAudioViewController.h"
#import "LocalAudio.h"
#import <AVFoundation/AVFoundation.h>
@interface FZHAudioViewController ()

@property (nonatomic, strong) LocalAudio  *audio;
@property (nonatomic, strong) UIView  *voiceView;
@property (nonatomic, weak) NSTimer   *voicetime;
@end

@implementation FZHAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 50, CGRectGetMidY(self.view.bounds) - 20, 100, 40);
    [btn setTitle:@"CopyAudio" forState:UIControlStateNormal];
    //处理按钮点击事件
    [btn addTarget:self action:@selector(btnstartRecord) forControlEvents:UIControlEventTouchDown];
    //处理按钮松开状态
    [btn addTarget:self action:@selector(btnstopRecord) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btn];

    UIButton *open = [UIButton buttonWithType:UIButtonTypeSystem];
    open.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 50, CGRectGetMidY(self.view.bounds) - 80, 100, 40);
    [open setTitle:@"open" forState:UIControlStateNormal];
    [open addTarget:self action:@selector(btnopenRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:open];
    

}
-(void)btnstartRecord{
    NSLog(@"start");
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if ([session respondsToSelector:@selector(requestRecordPermission:)]) {

        [session requestRecordPermission:^(BOOL granted) {

            if (granted) {
                NSLog(@"你的麦克风");
                [self.audio prepareRecorder];
                [self.view addSubview:self.voiceView];

                [self.voicetime fire];

            }else{
                NSLog(@"谁抢走了你的麦克风");
                // 用户不同意获取麦克风
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"麦克风不可用" message:@"请在“设置 - 隐私 - 麦克风”中允许XXX访问你的麦克风" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"前往开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                    //如果要让用户直接跳转到设置界面，则可以进行下面的操作，如不需要，就忽略下面的代码
                    /*
                     *iOS10 开始苹果禁止应用直接跳转到系统单个设置页面，只能跳转到应用所有设置页面
                     *iOS10以下可以添加单个设置的系统路径，并在info里添加URL Type，将URL schemes 设置路径为prefs即可。
                     *@"prefs:root=Sounds"
                     */
                    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];

                    if([[UIApplication sharedApplication] canOpenURL:url]) {

                        [[UIApplication sharedApplication] openURL:url];
                    }
                }];

                [alertController addAction:openAction];
                [self presentViewController:alertController animated:YES completion:nil];

            }

        }];
        
    }

}
-(void)btnstopRecord{
    NSLog(@"stop");
    [self.audio stopRecord];
    [self.voicetime invalidate];
    self.voicetime = nil;
    [self.voiceView removeFromSuperview];
}
-(void)btnopenRecord{
    [self.audio openRecord];
}
-(LocalAudio *)audio
{
    if (!_audio) {
        _audio = [LocalAudio sharedLocalAudio] ;
//        [_audio prepareRecorder];
    }
    return _audio;
}

-(NSTimer *)voicetime
{
    if (!_voicetime) {
        _voicetime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeHeight) userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer:_voicetime forMode:NSRunLoopCommonModes];
    }
    return  _voicetime;
}

-(UIView *)voiceView
{
    if (!_voiceView) {
        _voiceView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 40, 40)];
        _voiceView.backgroundColor = [UIColor grayColor];
    }
    return _voiceView;
}

- (void)changeHeight
{
    [UIView animateWithDuration:1.0 animations:^{
        CGFloat width = arc4random()%300 + 20;
        CGRect rect = self.voiceView.frame;
        rect.size.width = width;
        self.voiceView.frame = rect;
    }];
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
