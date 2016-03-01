//
//  SLAPIManager.h
//  0226news
//
//  Created by Tang on 16/2/26.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLAPIManager : NSObject
+ (instancetype)sharedApi;

/**
 *  请求头条广告数据
 *
 *  @param url     请求的路径
 *  @param success 成功回调
 *  @param error   失败回调
 */
- (void)requestHeadLineDataWithURL:(NSString *)url success:(void(^)(id responseObject))success error:(void(^)(NSError *errInfo))error;


/**
 *  请求新闻数据
 *
 *  @param url     请求的路径
 *  @param success 成功回调
 *  @param error   失败回调
 */
- (void)requestNewsDataWithURL:(NSString *)url success:(void(^)(id responseObject))success error:(void(^)(NSError *errInfo))error;
@end
