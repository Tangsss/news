//
//  SLNewsController.m
//  0226news
//
//  Created by Tang on 16/2/29.
//  Copyright © 2016年 大天朝. All rights reserved.
//
//新闻首页
//http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html

#import "SLNewsController.h"
#import "SLNewsModel.h"
#import "SLNewsCell.h"
#import "SLNewsDetailController.h"


@interface SLNewsController ()
@property(nonatomic,strong) NSArray *data;
@end

@implementation SLNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData
{
    [SLNewsModel newsDataWithURL:@"article/headline/T1348647853363/0-100.html" success:^(NSArray *news) {
        self.data = news;
        //刷新
        [self.tableView reloadData];
    }];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLNewsModel *model = self.data[indexPath.row];
    
    SLNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[SLNewsCell cellIdentiferWithNews:model] forIndexPath:indexPath];
    
    cell.news = model;
    
    return cell;
}
#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLNewsModel *model = self.data[indexPath.row];
    return [SLNewsCell cellHightWithNews:model];
}
//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"//跳到详情页");
    //跳到详情页
    SLNewsModel *model = self.data[indexPath.row];
    //初始化详情页控件
    SLNewsDetailController *detail = [[SLNewsDetailController alloc]init];
    detail.newsURL = model.fullURL;
    
    
    //push
    [self.navigationController pushViewController:detail animated:YES];
           NSLog(@"1跳到详情页");
    
}

@end
