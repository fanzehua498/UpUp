//
//  Tip.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/18.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "Tip.h"

@implementation Tip

/*
 1、设置tableView可不可以选中(防止cell重复点击也可以利用这条特性)

 self.tableView.allowsSelection = NO;
 2、允许tableview多选

 self.tableView.allowsMultipleSelection = YES;
 3、编辑模式下是否可以选中

 self.tableView.allowsSelectionDuringEditing = NO;
 4、编辑模式下是否可以多选

 self.tableView.allowsMultipleSelectionDuringEditing = YES;
 5、获取被选中的所有行

 [self.tableView indexPathsForSelectedRows]
 6、获取当前可见的行

 [self.tableView indexPathsForVisibleRows];
 7、 改变UITableViewCell选中时背景色

 cell.selectedBackgroundView.backgroundColor
 8、自定义UITableViewCell选中时背景

 cell.selectedBackgroundView
 9、自定义UITableViewCell选中时系统label字体颜色

 cell.textLabel.highlightedTextColor
 10、设置tableViewCell间的分割线的颜色

 [theTableView setSeparatorColor:[UIColor xxxx ]];
 11、pop返回table时，cell自动取消选中状态（在viewWillAppear中添加如下代码）

 [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
 12、点击后，过段时间cell自动取消选中

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
 }
 - (void)deselect {
    [self.tableview deselectRowAtIndexPath:[self.tableview indexPathForSelectedRow] animated:YES];
 }
*/

@end
