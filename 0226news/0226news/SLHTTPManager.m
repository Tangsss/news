//
//  SLHTTPManager.m
//  0226news
//
//  Created by Tang on 16/2/26.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import "SLHTTPManager.h"

@implementation SLHTTPManager
#define SLBaseURL [NSURL URLWithString:@"http://c.m.163.com/nc/"]
+ (instancetype)shanredManager
{
    static dispatch_once_t onceToken;
    static SLHTTPManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]initWithBaseURL:SLBaseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return instance;
}
@end
