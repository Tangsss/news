//
//  SLNewsDetailController.m
//  0226news
//
//  Created by Tang on 16/3/1.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import "SLNewsDetailController.h"

@interface SLNewsDetailController ()<UIWebViewDelegate>
@property(nonatomic,copy) UIWebView *webView;
@end

@implementation SLNewsDetailController
//- (void)loadView
//{
//    self.webView = [[UIWebView alloc]init];
//    self.webView.delegate = self;
//    self.view = self.webView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
        NSLog(@"跳到详情页");
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    [self loadData];
    
}
- (void)loadData
{
    NSLog(@"%@",self.newsURL);
}




@end
