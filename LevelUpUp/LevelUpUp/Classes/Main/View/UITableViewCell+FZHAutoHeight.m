//
//  UITableViewCell+FZHAutoHeight.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/24.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "UITableViewCell+FZHAutoHeight.h"

#import <objc/runtime.h>

@implementation UITableViewCell (FZHAutoHeight)


#pragma mark - 公gong方法
+(CGFloat)fzh_heightForTableView:(UITableView *)tableView config:(FZHCellBlock)config
{
    /**
     * objectForKey:任意取个唯一key
     *
     */
    UITableViewCell *cell = [tableView.fzh_reuseCells objectForKey:[[self class] description]];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [tableView.fzh_reuseCells setObject:cell forKey:[[self class] description]];
    }

    if (config) {
        config(cell);
    }
    return [cell Return_fzh_heightForTableView:tableView];
}

NSString *const kFZHCacheUniqueKey = @"kFZHCacheUniqueKey";
NSString *const kFZHCacheStateKey = @"kFZHCacheStateKey";
NSString *const kFZHRecalculateForStateKey = @"kFZHRecalculateForStateKey";
//NSString *const kFZHCacheForTableViewKey = @"kFZHCacheForTableViewKey";


//缓存的高度
+ (CGFloat)fzh_heightForTableView:(UITableView *)tableView config:(FZHCellBlock)config cache:(FZHCacheHeight)cache
{
    if (cache) {
        NSDictionary *cacheKeys = cache();
        NSString *stateKey = cacheKeys[kFZHCacheStateKey];
        NSString *key = cacheKeys[kFZHCacheUniqueKey];

        NSString *shouldUpdate = cacheKeys[kFZHRecalculateForStateKey];

        NSMutableDictionary *stateDict = tableView.fzh_cacheCellHeightDict[key];
        NSString *cacheHeight = stateDict[stateKey];

        if (!tableView || tableView.fzh_cacheCellHeightDict.count == 0 || shouldUpdate
            .boolValue || cacheHeight == nil) {
            CGFloat height = [self fzh_heightForTableView:tableView config:config];
            if (stateDict == nil) {
                stateDict = [[NSMutableDictionary alloc] init];
                tableView.fzh_cacheCellHeightDict[key] = stateDict;
            }
            [stateDict setObject:[NSString stringWithFormat:@"%lf",height] forKey:stateKey];
            return height;
        }else if (tableView.fzh_cacheCellHeightDict.count != 0 &&cacheHeight != nil && cacheHeight.integerValue != 0){

            return cacheHeight.floatValue;
        }

    }

    return [self fzh_heightForTableView:tableView config:config];
}


#pragma mark - 重写 fzh_lastViewInCell set get方法
const void *fzh_lastViewInCellKey = "fzh_lastViewInCellKey";
-(void)setFzh_lastViewInCell:(UIView *)fzh_lastViewInCell
{
    objc_setAssociatedObject(self, fzh_lastViewInCellKey, fzh_lastViewInCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)fzh_lastViewInCell
{
    return objc_getAssociatedObject(self, fzh_lastViewInCellKey);
}

#pragma mark - 重写 fzh_lastViewsInCell set get方法
-(void)setFzh_lastViewsInCell:(NSArray *)fzh_lastViewsInCell
{
    objc_setAssociatedObject(self, @selector(fzh_lastViewsInCell), fzh_lastViewsInCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSArray *)fzh_lastViewsInCell
{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - 重写 Fzh_bottomOffsetToCell set get方法

const void *Fzh_bottomOffsetToCellKey = "Fzh_bottomOffsetToCellKey";

-(void)setFzh_bottomOffsetToCell:(CGFloat)fzh_bottomOffsetToCell
{
    objc_setAssociatedObject(self, Fzh_bottomOffsetToCellKey, @(fzh_bottomOffsetToCell), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CGFloat)fzh_bottomOffsetToCell
{
    NSNumber *number = objc_getAssociatedObject(self, Fzh_bottomOffsetToCellKey);
    if ([number respondsToSelector:@selector(floatValue)]) {
        return number.floatValue;
    }
    return 0.0;
}


#pragma mark - 私有方法
- (CGFloat)Return_fzh_heightForTableView:(UITableView *)tableView
{
    NSAssert(self.fzh_lastViewInCell != nil || self.fzh_lastViewsInCell.count!= 0, @"您未指定cell排列的最后视图对象，无法进行计算高度");

    //layout subviews
    [self layoutIfNeeded];

    CGFloat rowHeight = 0.0;
    if (self.fzh_lastViewInCell) {
        //最后视图的高度 + y值
        rowHeight = self.fzh_lastViewInCell.frame.size.height + self.fzh_lastViewInCell.frame.origin.y;

    }else{
        //未设置最后视图 遍历fzh_lastViewsInCell（cell中的所有视图数组）
        for (UIView *subviews in self.fzh_lastViewsInCell) {
            if (rowHeight < CGRectGetMaxY(subviews.frame)) {
                rowHeight = CGRectGetMaxY(subviews.frame);
            }
        }
    }
    rowHeight += self.fzh_bottomOffsetToCell;

    return rowHeight;
}
@end
