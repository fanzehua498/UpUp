//
//  UITableViewCell+FZHAutoHeight.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/24.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+FZHCacheHeight.h"

/**
 * 获取高度前会回调，需要在此BLOCK中配置数据，才能正确地获取高度
 */

typedef void(^FZHCellBlock)(UITableViewCell *sourceCell);


typedef NSDictionary *(^FZHCacheHeight)();
@interface UITableViewCell (FZHAutoHeight)


/**
 * @note UI布局必须放在UITableViewCell的初始化方法中：
 *
 * - initWithStyle:reuseIdentifier:
 *
 * 且必须指定hyb_lastViewInCell才能生效
 */
/**
 *  必传设置的属性，也就是在cell中的contentView内最后一个视图，用于计算行高
 * 例如，创建了一个按钮button作为在cell中放到最后一个位置，则设置为：self.fzh_lastViewInCell = button;
 * 即可。
 * 默认为nil，如果在计算时，值为nil，会crash
 */
@property (nonatomic, strong) UIView  *fzh_lastViewInCell;

/**
 *  当距离分割线的视图不确定时，可以将可能的所有视图放在这个数组里面，优先级低于上面的属性，也就是当`fzh_lastViewInCell`有值时，`fzh_lastViewsInCell`不起作用。
 */
@property (nonatomic, strong) NSArray  *fzh_lastViewsInCell;

/**
 * 可选设置的属性，默认为0，表示指定的fzh_lastViewInCell到cell的bottom的距离
 * 默认为0.0
 */
@property (nonatomic, assign) CGFloat fzh_bottomOffsetToCell;

/**
 * 通过此方法来计算行高，需要在config中调用配置数据的API
 *
 * @param tableView 必传，为哪个tableView缓存行高
 * @param config     必须要实现，且需要调用配置数据的API
 *
 * @return 计算的行高
 */
+ (CGFloat)fzh_heightForTableView:(UITableView *)tableView config:(FZHCellBlock)config;

/**
 *
 *	此API会缓存行高
 *
 *	@param tableView 必传，为哪个tableView缓存行高
 *	@param config 必须要实现，且需要调用配置数据的API
 *	@param cache  返回相关key
 *
 *	@return 行高
 */
+ (CGFloat)fzh_heightForTableView:(UITableView *)tableView
                           config:(FZHCellBlock)config
                            cache:(FZHCacheHeight )cache;

@end
