//
//  PaUrlViewController.m
//  LevelUpUp
//
//  Created by 范泽华 on 2017/8/19.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import "PaUrlViewController.h"
#import "testView.h"
@interface PaUrlViewController ()<UIWebViewDelegate>
@property(nonatomic,strong) testView *v;
@end

@implementation PaUrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"papapa";
//    NSString *data = [self urlstring:@"https://www.ddd42.com"];
    
//    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.dianping.com/tuan/deal/8157270"]]];
////     [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ddd42.com"]]];
//    web.delegate = self;
//    [self.view addSubview:web];

    self.v = [[testView alloc] initWithFrame:CGRectMake(0, 200, 375, 600)];
    self.v.backgroundColor = [UIColor whiteColor];
    self.v.imageArr = @[@"1"];
    [self.view addSubview:self.v];
    NSLog(@"%d",9%4);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSInteger count = self.v.imageArr.count + 1 ;
    NSMutableArray *ar = [NSMutableArray array];
    for (int i = 0; i <count; i ++) {
        [ar addObject:@"1"];
    }
    NSLog( @"count:%ld",count);
    self.v.imageArr = ar;
    [self.v update];
//    [self.view setNeedsLayout];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //document.location.href"];
    NSMutableString *js = [NSMutableString string];
    // 2.删除顶部的导航条
    [js appendString:@"var header = document.getElementsByTagName('header')[0];"];
    [js appendString:@"header.parentNode.removeChild(header);"];
    [webView stringByEvaluatingJavaScriptFromString:js];

    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
  


//    NSString *active = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('active');"];

//    NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsById('dt');"];
     NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"center margintop border clear main\")[0].getElementsByClassName;"];

    html = [html stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[html componentsSeparatedByString:@"\t"]];
    
    
    
    NSLog(@"aarr %ld %@ ",arr.count,arr);
    
    NSLog(@"html:%@",html);
    [js appendString:@"var btn = document.getElementsByClassName(\"footer-btn-fix\")[0];"];
    [js appendString:@"btn.parentNode.removeChild(btn);"];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
    
    NSMutableString *address = [NSMutableString string];
    // 6.1首先获取到该标签元素
    [address appendString:@"var address = document.getElementsByClassName(\"center margintop border clear main\")[0];"];
    // 6.2获取到该标签元素的文本内容
    [address appendString:@"address.innerText"];
    
    // 6.3输出内容
    NSLog(@"%@", [webView stringByEvaluatingJavaScriptFromString:address]);
    NSString *qiege = [webView stringByEvaluatingJavaScriptFromString:address];
    NSLog(@"qiege%@", qiege);
    NSMutableArray *aaaaaa = [NSMutableArray arrayWithArray:[qiege componentsSeparatedByString:@"\n"]];
    NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('%@').length", @"href"];
    
    int count =  [[webView stringByEvaluatingJavaScriptFromString:jsString] intValue];
  
    
}


//-(NSString*)urlstring:(NSString*)strurl{
//　　　　NSURL *url = [NSURL URLWithString:strurl];
//　　　　NSData *data = [NSData dataWithContentsOfURL:url];
//
//　　　　NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//　　　　NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
//
//　　　　//NSLog(@" html = %@",retStr);
//
//　　　　return retStr;
//}
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
