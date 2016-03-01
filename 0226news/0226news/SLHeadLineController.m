//
//  SLHeadLineController.m
//  0226news
//
//  Created by Tang on 16/2/26.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import "SLHeadLineController.h"
#import "SLHeadLineCell.h"
#import "SLHeadLineModel.h"


@interface SLHeadLineController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageView;

@property(nonatomic,strong) NSArray *datas;
@end

@implementation SLHeadLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

}
- (void)loadData
{
    //http://c.m.163.com/nc/ad/headline/0-4.html
    [SLHeadLineModel headLineDatasWithURL:@"ad/headline/0-4.html" success:^(NSArray *headLines) {
        self.datas = headLines;
        //刷新界面
        [self.collectionView reloadData];
        //设置分页
        self.pageView.numberOfPages = self.datas.count;
        //设置第一页的标题
        [self scrollViewDidEndDecelerating:self.collectionView];
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setupView];
    
}
- (void)setupView
{
    //设置背景色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //设置item
    self.FlowLayout.itemSize = self.collectionView.bounds.size;
    //设置水平滚动
    self.FlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置分页
    self.collectionView.pagingEnabled = YES;
    //关闭滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //关闭弹簧
    self.collectionView.bounces = YES;
    //设置间隔
    self.FlowLayout.minimumLineSpacing = 0;
    
}
#pragma mark - UICollectionViewDataSource 代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10000;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLHeadLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLHeadLineCell" forIndexPath:indexPath];
    cell.headLineMoldel = self.datas[indexPath.item];
    return cell;
}
// 在滚动结束的时候判断一下这前是第几张
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"滚动结束");
    NSInteger index = (NSInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width) % self.datas.count;
    
    //取出当前页
    SLHeadLineModel *model = self.datas[index];
    
    //设置标题
    self.titleLabel.text = model.title;
    
    //设置当前页
    self.pageView.currentPage = index;
}

@end
