//
//  SLNewsModel.m
//  0226news
//
//  Created by Tang on 16/2/29.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import "SLNewsModel.h"
#import "SLAPIManager.h"
#import <YYModel.h>

@implementation SLNewsModel
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"imgextra" : [SLNewsImageModel class]
             };
}
- (void)setDocid:(NSString *)docid
{
    _docid = docid;
    self.fullURL = [NSString stringWithFormat:@"article/%@/full.html",docid];
}

+ (void)newsDataWithURL:(NSString *)url success:(void (^)(NSArray *))success
{
    NSAssert(success != nil, @"回调不能为空");
    [[SLAPIManager sharedApi]requestNewsDataWithURL:url success:^(NSDictionary *responseObject) {
        //取出第一个key
        NSString *key = responseObject.keyEnumerator.nextObject;
        
        NSArray *data = responseObject[key];
        
        NSArray *tmp = [NSArray yy_modelArrayWithClass:self json:data];
        
        success(tmp);
    } error:^(NSError *errInfo) {
        success(nil);
    }];
}
@end
