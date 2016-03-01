//
//  SLNewsModel.h
//  0226news
//
//  Created by Tang on 16/2/29.
//  Copyright © 2016年 大天朝. All rights reserved.
//
//新闻首页
//http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html

#import <Foundation/Foundation.h>
#import "SLNewsImageModel.h"

@interface SLNewsModel : NSObject
@property(nonatomic,copy) NSString *title;///<标题
@property(nonatomic,copy) NSString *digest;///<副标题
@property(nonatomic,copy) NSString *replyCount;///<跟帖人数
@property(nonatomic,copy) NSString *imgsrc;///<图片
@property(nonatomic,strong) NSArray<SLNewsImageModel *> *imgextra;///<更多图片
@property(nonatomic,assign) NSInteger imgType;///<图片类型  1是大图  默认0小图
@property(nonatomic,copy) NSString *docid;
@property(nonatomic,copy) NSString *fullURL;///<新闻详情路径
/**
 *  加载新闻数据
 *
 *  @param url     新闻的路径
 *  @param success 数据的回调
 */
+ (void)newsDataWithURL:(NSString *)url success:(void(^)(NSArray *news))success;
@end
