//
//  CustumCardLayout.m
//  LevelUpUp
//
//  Created by 范泽华 on 2017/10/9.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import "CustumCardLayout.h"

CGFloat ActiveDistance = 400;//垂直缩放除以系数
CGFloat ScaleFactor = 0.25;//缩放系数 越大缩放越大
@implementation CustumCardLayout

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
{
    CGRect tarRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    //目标区域中包含的cell
    NSArray *attriArr = [super layoutAttributesForElementsInRect:tarRect];
    // collectionView落在屏幕中点的x坐标
    CGFloat horizontalCenterX = proposedContentOffset.x + (self.collectionView.bounds.size.width / 2.0);
    CGFloat offsetAdjustment = CGFLOAT_MAX;
    
    for (UICollectionViewLayoutAttributes *attr in attriArr) {
        CGFloat itemHorizontalCenterX = attr.center.x;
        if (fabs(itemHorizontalCenterX - horizontalCenterX) < fabs(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenterX - horizontalCenterX;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arrar = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.width);
    
    for (UICollectionViewLayoutAttributes *attributes in arrar) {
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normaLizedDistance = fabs(distance/ActiveDistance);
        CGFloat zooom = 1 - ScaleFactor * normaLizedDistance;
        attributes.transform3D = CATransform3DMakeScale(zooom, zooom, 1.0);
        
        CGRect re = attributes.frame;
        re.origin.y = fabs(distance *ScaleFactor);
    
        attributes.frame = re;
    }
    
    return arrar;
}

// 滑动放大缩小  需要实时刷新layout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
