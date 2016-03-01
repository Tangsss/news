//
//  SLHTTPManager.h
//  0226news
//
//  Created by Tang on 16/2/26.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface SLHTTPManager : AFHTTPSessionManager
+ (instancetype)shanredManager;
@end
