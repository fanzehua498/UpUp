//
//  ScollerCard.m
//  LevelUpUp
//
//  Created by 范泽华 on 2017/10/9.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import "ScollerCard.h"
#import "CustumCardLayout.h"
#import "UIView+FFFView.h"
#import "CustumCardCell.h"


#define  screen_width  [UIScreen mainScreen].bounds.size.width
#define screen_height  [UIScreen mainScreen].bounds.size.height

@interface ScollerCard ()<UICollectionViewDelegate,UICollectionViewDataSource>



@property(nonatomic,strong) UICollectionView *collerctionView;



@end



@implementation ScollerCard


- (UICollectionView *)collerctionView
{
    if (!_collerctionView) {
        CustumCardLayout *cusLayout = [[CustumCardLayout alloc] init];
        
        cusLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        cusLayout.sectionInset = UIEdgeInsetsMake(0, [self fillScrennWidth:107] * 2, 0, [self fillScrennWidth:107] * 2);
        cusLayout.minimumLineSpacing = - [self fillScrennWidth:40];
        cusLayout.itemSize = CGSizeMake([self fillScrennWidth:107] , [self fillScreenHeight:130]);
        CGFloat padding = [self fillScrennWidth:35];

        
        
        _collerctionView = [[UICollectionView alloc] initWithFrame:CGRectMake(padding, 0, screen_width - padding * 2, [self fillScreenHeight:157]) collectionViewLayout:cusLayout];
        //    _collerctionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:cusLayout];
        _collerctionView.backgroundColor = [UIColor clearColor];
        _collerctionView.collectionViewLayout = cusLayout;
        _collerctionView.showsHorizontalScrollIndicator = NO;
        _collerctionView.pagingEnabled = YES;
        _collerctionView.delegate = self;
        _collerctionView.dataSource = self;
       
        [_collerctionView registerNib:[UINib nibWithNibName:@"CustumCardCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CustumCardCell"];
    }
    return _collerctionView;
}


- (CGFloat)fillScreenHeight:(CGFloat)height
{
    return height * screen_height / 375.0;
}

- (CGFloat)fillScrennWidth:(CGFloat)width
{
    return width * screen_width / 375.0;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.y = self.height;
        self.models = @[@"C语言程序与设计", @"Swift入门与实践", @"教你怎么不生气", @"沉默的愤怒", @"颈椎病康复指南", @"腰椎间盘突出日常护理", @"心脏病的预防与防治", @"高血压降压宝典", @"精神病症状学", @"活着"];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
      
        
        

        
        
        //灯光
//        UIImageView *linghtView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [self fillScreenHeight:200], [self fillScrennWidth:245], [self fillScreenHeight:125])];
        UIImageView *linghtView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [self fillScrennWidth:245], [self fillScreenHeight:125])];
//        linghtView.centerX = self.centerX;
        linghtView.image = [UIImage imageNamed:@"img_dengguang"];
//        [self addSubview:linghtView];
        [self addSubview:self.collerctionView];
//        设置阴影效果
        self.layer.shadowColor = [UIColor colorWithWhite:0.75 alpha:1].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 2);//偏移距离
        self.layer.shadowOpacity=1;//不透明
        self.layer.shadowRadius = 1.0;//半径
        
        
    }
    return self;
}

- (void)setModels:(NSArray *)models
{
    _models = models;
    if (models.count < 2) {
        self.collerctionView.scrollEnabled = NO;
    }
//    [self.collerctionView reloadData];
}


-(void)show
{
//    UIApplication *sha = [UIApplication sharedApplication];
//    [sha.keyWindow addSubview:self];
}

- (void)removeCard
{
    [UIView animateWithDuration:0.5 animations:^{
//        self.frame.origin.y = self.bounds.size.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - delegate datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.models.count);
    return self.models.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CustumCardCell";
    CustumCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
   
    cell.cellTextLabel.text = self.models[indexPath.row];
    NSString *imgName = [NSString stringWithFormat:@"img_book%ld",indexPath.row % 3];
    cell.imageView.image = [UIImage imageNamed:imgName];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    CGPoint pointInView = [collectionView convertPoint:self.collerctionView.center toView:collectionView];
    NSIndexPath *centerIndex = [collectionView indexPathForItemAtPoint:pointInView];
    if (index == centerIndex.row) {
        CustumCardCell *cell = (CustumCardCell *)[collectionView cellForItemAtIndexPath:centerIndex];
        CATransition *ca = [[CATransition alloc] init];
//        ca.delegate = self;
        ca.type = @"pageCurl";
        ca.subtype = kCATransitionFromRight;
        [cell.contentView.layer addAnimation:ca forKey:nil];
        
    }else{
        [self scrollToTouchItem:YES index:index];
        NSLog(@"点击了：%ld",index);
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    CGPoint pointInView = [self convertPoint:self.collerctionView.center toView:self.collerctionView];
//    NSIndexPath *index = [self.collerctionView indexPathForItemAtPoint:pointInView];
//    NSLog(@"%@",index);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint pointInView = [self convertPoint:self.collerctionView.center toView:self.collerctionView];
    NSIndexPath *index = [self.collerctionView indexPathForItemAtPoint:pointInView];
    NSLog(@"%@",index);
    
    NSIndexPath *dexpath = [NSIndexPath indexPathForRow:index.row - 2 inSection:0];
    
    
//    CustumCardCell *cell = (CustumCardCell*)[self.collerctionView cellForItemAtIndexPath:index];
    if ([self.collerctionView cellForItemAtIndexPath:dexpath]) {
        CustumCardCell *cell = (CustumCardCell*)[self.collerctionView cellForItemAtIndexPath:dexpath];
        [self.collerctionView bringSubviewToFront:cell];
    }
    
    if ([self.collerctionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index.row + 2 inSection:0]]) {
        CustumCardCell *cell = (CustumCardCell*)[self.collerctionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index.row + 2 inSection:0]];
        [self.collerctionView bringSubviewToFront:cell];
    }
    if ([self.collerctionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index.row - 1 inSection:0]]) {
        CustumCardCell *cell = (CustumCardCell*)[self.collerctionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index.row - 1 inSection:0]];
        [self.collerctionView bringSubviewToFront:cell];
    }
    if ([self.collerctionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index.row + 1 inSection:0]]) {
        CustumCardCell *cell = (CustumCardCell*)[self.collerctionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index.row + 1 inSection:0]];
        [self.collerctionView bringSubviewToFront:cell];
    }
    if ([self.collerctionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index.row  inSection:0]]) {
        CustumCardCell *cell = (CustumCardCell*)[self.collerctionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index.row  inSection:0]];
        [self.collerctionView bringSubviewToFront:cell];
    }
}


- (void)scrollToTouchItem:(BOOL)animation index:(NSInteger)index
{
    NSInteger ind = index <self.models.count ? index : 0;
    [self.collerctionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:ind inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animation];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
