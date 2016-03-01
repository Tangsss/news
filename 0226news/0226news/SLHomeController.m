//
//  SLHomeController.m
//  0226news
//
//  Created by Tang on 16/3/1.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import "SLHomeController.h"
#import "SLChannelModel.h"
#import "SLhannelLabel.h"
#import "SLhannelNewsCell.h"
#import "SLNewsController.h"


@interface SLHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property(nonatomic,assign) NSInteger currentPage;///<当前在哪一页
@property(nonatomic,strong) NSArray *channels;///<频道数据
@property(nonatomic,strong) NSMutableDictionary *newsVCCache;///<控制器缓存
@end

@implementation SLHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 在导航控制器下面，scrollView或者它的子类，会默认被设置了一个contentInsets -> (0,64)
    // 使用以下代码来关闭默认的调整
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    [self loadChanneData];
}
- (void)loadChanneData{
    NSArray *channels = [SLChannelModel channelDatas];
    
    //排序
    channels = [channels sortedArrayUsingComparator:^NSComparisonResult(SLChannelModel*  _Nonnull obj1, SLChannelModel*  _Nonnull obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    
    //设置文字
    __block CGFloat labelX = 0;
    [channels enumerateObjectsUsingBlock:^(SLChannelModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //算坐标
        CGFloat labelY = 0;
        CGFloat labelH = self.scrollView.bounds.size.height;
        SLhannelLabel *label = [SLhannelLabel channelLabelWithTitle:obj.tname];
        CGFloat labelW = label.bounds.size.width;
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        labelX += labelW;
        
        
        
        __weak typeof (label) weakLabel = label;
        __weak typeof(self) weakSelf = self;
        [label setClickChannel:^{
            //切换频道
            [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            
            //当前的变小
            SLhannelLabel *currenChannel = weakSelf.scrollView.subviews[weakSelf.currentPage];
            currenChannel.scale = 0;
            //点击变大
            weakLabel.scale = 1;
            weakSelf.currentPage = idx;
            
            [weakSelf adjScrollViewContentOffset];
        }];
        if (idx == 0) {
            //默认第一个
            label.scale = 1;
        }
        [self.scrollView addSubview:label];
    }];
    
    //设置滚动范围
    self.scrollView.contentSize = CGSizeMake(labelX, 0);
    self.channels = channels;
    [self.collectionView reloadData];
    
}
- (void)adjScrollViewContentOffset{
    //取出当前频道
    SLhannelLabel *hanne = self.scrollView.subviews[self.currentPage];
    
    CGFloat offsetX = hanne.center.x - CGRectGetWidth(self.scrollView.frame) * 0.5;
    if (offsetX < 0) {
        offsetX = 0;// 如果点击的是前面几个标签，让scrollview滚动到初始化的位置
    }
    // 判断如果是到最后几个，不需要offset 到 频道的中点
    CGFloat maxOffsetX = (self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.frame));
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setupView];
}
/**
 *  设置view布局以及其他样式
 */
- (void)setupView{
    
    self.collectionView.backgroundColor = [UIColor whiteColor];//设置背景
    self.layout.itemSize = self.collectionView.bounds.size;//设置item
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平滚动
    self.scrollView.showsHorizontalScrollIndicator = NO;//隐藏滚动条
    self.layout.minimumLineSpacing = 0;//设置间隔
    self.collectionView.pagingEnabled = YES;//设置分页
    self.collectionView.bounces = NO;//关闭弹簧
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLhannelNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLhannelNewsCell" forIndexPath:indexPath];
    
    //移除旧view
    [cell.news.view removeFromSuperview];
    
    SLChannelModel *channel = self.channels[indexPath.item];
    //取出频道对应
    SLNewsController *news = [self newsControllerWithChannel:channel];
    
    if (![self.childViewControllers containsObject:news]) {
//        NSLog(@"添加子控制器");
        // 把控制器添加到子控制器，否则会影响响应者链条
        [self addChildViewController:news];
    }
    news.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:news.view];
    
    cell.news = news;
    return cell;
}

/**
 *  从缓存中加载新闻的控制器
 *
 *  @param channel 对应的频道
 *
 *  @return 新闻控制器
 */
- (SLNewsController *)newsControllerWithChannel:(SLChannelModel *)channel{
    SLNewsController *news = [self.newsVCCache objectForKey:channel.tid];
    // 如果是nil手动初始化
    if (news == nil) {
        //把新闻控制器加进来
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"news" bundle:nil];
        //起始控制器是NavigationController时用
//        UINavigationController *navc = (UINavigationController *)[sb instantiateInitialViewController];
//    
//        news = (SLNewsController *)navc.topViewController;
        news = [sb instantiateInitialViewController];
        
        news.channelId = channel.tid;
        //添加到缓存
        [self.newsVCCache setObject:news forKey:channel.tid];
    }
    return news;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //取出当前频道
    SLhannelLabel *currentChannel = self.scrollView.subviews[self.currentPage];
    
    __block SLhannelLabel *nextChannel;
    
    // 取出当前可视范围内的collectionViewCell对应的IndexPath
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath  *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.item != self.currentPage) {
            //下一页/上一页
            nextChannel = self.scrollView.subviews[obj.item];
        }
    }];
    if (nextChannel == nil) {
        return;//没有下一个频道
    }
    
    //偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    CGFloat scale = ABS(offsetX / scrollView.bounds.size.width - self.currentPage);//放大
    CGFloat currentScale = 1 -scale;//缩小
    
    nextChannel.scale = scale;
    currentChannel.scale = currentScale;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currentPage = (NSInteger)offsetX / scrollView.bounds.size.width;
    //调整频道栏的位置
    [self adjScrollViewContentOffset];
}


#pragma mark - 懒加载
- (NSMutableDictionary *)newsVCCache
{
    if (!_newsVCCache) {
        _newsVCCache = [NSMutableDictionary dictionary];
    }
    return _newsVCCache;
}
@end
