//
//  FZH_ScrollView.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/6.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZH_ScrollView.h"
@interface FZH_ScrollView ()<UIScrollViewDelegate>
{
    UIImageView *_leftImageView, *_middleImageView, *_rightImageView;
    NSInteger _currentIndex;
}
@property (nonatomic, strong) UIPageControl  *pageControl;

@property (nonatomic, strong) UIScrollView  *scrollImageView;
@property (nonatomic, assign) CGSize scorllViewSize;
// 定时器
@property (nonatomic, strong) NSTimer  *timer;


@end


@implementation FZH_ScrollView

-(void)setAutoScrollDeley:(NSTimeInterval)autoScrollDeley
{
    _autoScrollDeley = autoScrollDeley;
//    [self removeTimer];
//    [self addTimer];
}

-(void)setIsScroll:(BOOL)isScroll
{
    _isScroll = isScroll;
    if (isScroll && self.imageArr.count > 1) {
        self.autoScrollDeley = 3;
    }
}

-(void)setImageArr:(NSArray *)imageArr
{
    _imageArr = imageArr;
    if (imageArr.count == 1) {
        _imageArr = @[imageArr[0],imageArr[0],imageArr[0]];
        self.pageControl.numberOfPages = 0;
        [self changeImage:imageArr.count - 1 minddle:0 right:1];
    }else{
        self.pageControl.numberOfPages = imageArr.count;
        [self changeImage:imageArr.count - 1 minddle:0 right:1];
    }
    [self addTimer];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.scorllViewSize = self.frame.size;

        [self loadImageViews];
    }
    return self;
}

- (void)loadImageViews
{

    _currentIndex = 0;
    //   初始化scrollImageView
    self.scrollImageView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.scrollImageView.backgroundColor = [UIColor grayColor];
    self.scrollImageView.pagingEnabled = YES;
    self.scrollImageView.showsHorizontalScrollIndicator = NO;
    self.scrollImageView.delegate = self;
    self.scrollImageView.contentSize = CGSizeMake(self.scorllViewSize.width * 3, 0);
    [self addSubview:self.scrollImageView];

    //重用的imageView
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scorllViewSize.width, self.scorllViewSize.height)];
    _middleImageView.backgroundColor = [UIColor redColor];

    _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scorllViewSize.width, 0, self.scorllViewSize.width, self.scorllViewSize.height)];

    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scorllViewSize.width * 2, 0, self.scorllViewSize.width, self.scorllViewSize.height)];

    [self.scrollImageView addSubview:_leftImageView];
    [self.scrollImageView addSubview:_middleImageView];
    [self.scrollImageView addSubview:_rightImageView];

    //分页控制 UIPageControl初始化
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.scorllViewSize.height - 16, self.scorllViewSize.width, 16)];
    //默认颜色
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    //    当前颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPage = _currentIndex;
//    self.pageControl.numberOfPages = 7;
    [self addSubview:self.pageControl];

    //图片添加点击事件
//    _middleImageView.userInteractionEnabled = YES;
//    [_middleImageView addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
//    _leftImageView.userInteractionEnabled = YES;
//    [_leftImageView addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickleft)]];
//    _rightImageView.userInteractionEnabled = YES;
//    [_rightImageView addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickleft2)]];
    //    [self addTimer];
}

//图片点击事件
- (void)imageClick
{
    NSLog(@"click");
}
- (void)imageClickleft
{
    NSLog(@"click1");
}
- (void)imageClickleft2
{
    NSLog(@"click2");
}
- (void)addTimer
{
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(scrollScroll) userInfo:nil repeats:YES];
//    self.timer = [NSTimer timerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self.scrollImageView setContentOffset:CGPointMake(self.scrollImageView.contentOffset.x + self.scorllViewSize.width, 0) animated:YES];
//    }];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"dd");
//        [self.scrollImageView setContentOffset:CGPointMake(self.scrollImageView.contentOffset.x + self.scorllViewSize.width, 0) animated:YES];
////        NSLog(@"%lf",self.scrollImageView.contentOffset.x + self.scorllViewSize.width);
//    }];
#warning 不要Fire 加入runloop就可以。 
#warning 加了会出现 左滑操作会先右滑再开始左滑
//    [self.timer fire];
}

- (void)scrollScroll
{
    NSLog(@"dd");
    [self.scrollImageView setContentOffset:CGPointMake(self.scrollImageView.contentOffset.x + self.scorllViewSize.width, 0) animated:YES];
    NSLog(@"dd0");
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark - UIScrollViewDelegate
// 开始用手滚动时干掉定时器

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    [self.timer invalidate];
//    self.timer = nil;
    [self removeTimer];
}

// 用手滚动结束时重新添加定时器
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    [self addTimer];
}



//滚动时计算scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    int offSetX = self.scrollImageView.contentOffset.x;
        if (self.imageArr.count == 1) {
            [self changeImage:0 minddle:0 right:0];
    
        }
    
        else{
    

        }

    //右滑
#warning = pageControl.currentPage变换才会流畅
    if (offSetX >= self.scrollImageView.frame.size.width * 2) {
        _currentIndex += 1;
        if (_currentIndex == self.imageArr.count) {
            _currentIndex = 0;
            [self changeImage:(self.imageArr.count - 1) minddle:0 right:1];
        }else if (_currentIndex == self.imageArr.count - 1){

            [self changeImage:_currentIndex - 1 minddle:self.imageArr.count - 1 right:0];
        }else{

            [self changeImage:_currentIndex - 1 minddle:_currentIndex  right:_currentIndex + 1];
        }
    }
    //    左滑
    if (offSetX <= 0) {
        _currentIndex -= 1;

        if (_currentIndex == -1) {
            _currentIndex = self.imageArr.count - 1;
            [self changeImage:_currentIndex - 1 minddle:_currentIndex right:0];
        }else if (_currentIndex == 0){

            [self changeImage:self.imageArr.count - 1    minddle:_currentIndex right:_currentIndex + 1];
        }else{
            [self changeImage:_currentIndex - 1 minddle:_currentIndex right:_currentIndex + 1];
        }
    }

    self.pageControl.currentPage = _currentIndex;
    NSLog(@"%ld",_currentIndex);



}


- (void)changeImage:(NSInteger)left minddle:(NSInteger)minddle right:(NSInteger)right
{
    //给重用的三个imageView附上图片
    _leftImageView.image = [UIImage imageNamed:self.imageArr[left]];
    _middleImageView.image = [UIImage imageNamed:self.imageArr[minddle]];
    _rightImageView.image = [UIImage imageNamed:self.imageArr[right]];
    //显示在屏幕的其实是第二张图片
    [self.scrollImageView setContentOffset:CGPointMake(self.scrollImageView.bounds.size.width, 0) animated:NO];
}

@end
