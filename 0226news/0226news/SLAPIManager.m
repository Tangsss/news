//
//  SLAPIManager.m
//  0226news
//
//  Created by Tang on 16/2/26.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import "SLAPIManager.h"
#import "SLHTTPManager.h"

@implementation SLAPIManager
+ (instancetype)sharedApi
{
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)requestHeadLineDataWithURL:(NSString *)url success:(void (^)(id))success error:(void (^)(NSError *))error
{
    [[SLHTTPManager shanredManager]GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull errorInfo) {
        if (error) {
            error(errorInfo);
        }
    }];
}

- (void)requestNewsDataWithURL:(NSString *)url success:(void (^)(id))success error:(void (^)(NSError *))error
{
    [[SLHTTPManager shanredManager]GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull errorInfo) {
        if (error) {
            error(errorInfo);
        }
    }];
}
@end
