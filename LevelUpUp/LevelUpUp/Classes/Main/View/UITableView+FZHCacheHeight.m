//
//  UITableView+FZHCacheHeight.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/24.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "UITableView+FZHCacheHeight.h"
#import <objc/runtime.h>

static const void *__fzh_tableView_cacheCellHeight = "__fzh_tableView_cacheCellHeight";

static const void *__fzh_tableView_reuseCellsKey = "__fzh_tableView_cacheCellHeight";

@implementation UITableView (FZHCacheHeight)

/**
 * objc_getAssociatedObject(id object, const void *key)
 *
 * objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
 *  param1:表示关联者，是一个对象，变量名理所当然也是object
 *  param2:获取被关联者的索引key
 *  param3:被关联者,这里为cells
 *  param4:关联时采用的协议，有assign，retain，copy等协议，一般使用OBJC_ASSOCIATION_RETAIN_NONATOMIC
 */

-(NSMutableDictionary *)fzh_cacheCellHeightDict
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, __fzh_tableView_cacheCellHeight);
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, __fzh_tableView_cacheCellHeight, dict, OBJC_ASSOCIATION_RETAIN);
    }
    return dict;
}

- (NSMutableDictionary *)fzh_reuseCells
{
    NSMutableDictionary *cells = objc_getAssociatedObject(self, __fzh_tableView_reuseCellsKey);
    if (!cells) {
        cells = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, __fzh_tableView_reuseCellsKey, cells, OBJC_ASSOCIATION_RETAIN);
    }
    return cells;
}
@end
