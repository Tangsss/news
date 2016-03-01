//
//  SLNewsDetailController.m
//  0226news
//
//  Created by Tang on 16/3/1.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import "SLNewsDetailController.h"
#import "SLHTTPManager.h"

@interface SLNewsDetailController ()<UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webView;
@property(nonatomic,copy) NSString *newsTitle;///<新闻标题
@property(nonatomic,copy) NSString *time;///<新闻时间
@property(nonatomic,copy) NSString *body;///<新闻内容
@end

@implementation SLNewsDetailController
- (void)loadView
{
    self.webView = [[UIWebView alloc]init];
    self.webView.delegate = self;
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    [self loadData];
    
}
- (void)loadData
{
//    NSLog(@"%@",self.newsURL);
    [[SLHTTPManager shanredManager]GET:self.newsURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        //取出key
        NSString *key = responseObject.keyEnumerator.nextObject;
        //取出数据
        NSDictionary *result = responseObject[key];
        //取出body内容
        __block NSString *body = result[@"body"];
        //取出所有的图片
        NSArray *images = result[@"img"];
        //循环替换图片
        [images enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *ref = obj[@"ref"];
            //替换字符串
            body = [body stringByReplacingOccurrencesOfString:ref withString:[self imageHTMLWithDict:obj]];
        }];
        self.body = body;
        self.newsTitle = result[@"title"];
        self.time = [NSString stringWithFormat:@"%@  %@",result[@"ptime"],result[@"source"]];
        //本地html文件的路径
        NSURL *url = [[NSBundle mainBundle]URLForResource:@"detail.html" withExtension:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了");
    }];
}

- (NSString *)imageHTMLWithDict:(NSDictionary *)dict{
    NSString *html = [NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\"  alt=\"%@\"/>",dict[@"src"],dict[@"alt"]];
    return html;
}

#pragma mark - UIWebViewDelegate代理
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *code = [NSString stringWithFormat:@"changeContent('%@','%@','%@')",self.newsTitle,self.time,self.body];
    [webView stringByEvaluatingJavaScriptFromString:code];
    
}
@end
