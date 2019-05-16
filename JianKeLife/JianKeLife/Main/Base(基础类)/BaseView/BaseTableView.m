//
//  BaseTableView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/21.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()

@end
@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        /***
         在iOS11中如果不实现 -tableView: viewForHeaderInSection:和-tableView: viewForFooterInSection: ，则-tableView: heightForHeaderInSection:和- tableView: heightForFooterInSection:不会被调用，导致它们都变成了默认高度，这是因为tableView在iOS11默认使用Self-Sizing，tableView的estimatedRowHeight、estimatedSectionHeaderHeight、 estimatedSectionFooterHeight三个高度估算属性由默认的0变成了UITableViewAutomaticDimension,就是实现对应方法或把这三个属性设为0。
         ***/
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedRowHeight = 0;

        
        MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        self.mj_header = header;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
        self.mj_footer = footer;
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
        footer.stateLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:AdaptationWidth(12)];
        footer.stateLabel.textColor = XColorWithRBBA(34, 58, 80, 0.32);
        self.mj_footer.hidden = YES;
        
    }
    return self;
}


/**
 tableView的上拉刷新事件
 */
-(void)headerRefresh{}

/**
 tableView的下拉加载事件
 */
-(void)footerRefresh{}
@end
