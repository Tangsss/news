//
//  SLHeadLineModel.m
//  0226news
//
//  Created by Tang on 16/2/26.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import "SLHeadLineModel.h"
#import "SLAPIManager.h"

@implementation SLHeadLineModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)headLineWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

/// 防止调用 setValuesForKeysWithDictionary(KVC)造成程序崩了
- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    
}

+ (void)headLineDatasWithURL:(NSString *)url success:(void(^)(NSArray *headLines))success
{
    NSAssert(success != nil, @"回调不能为空");
    [[SLAPIManager sharedApi]requestHeadLineDataWithURL:url success:^(NSDictionary *responseObject) {
        //取出字典中的第一个key
        NSString *key = responseObject.keyEnumerator.nextObject;
        //取出数据数组
        NSArray *data = responseObject[key];
        
        //可变数组存放模型数据
        NSMutableArray *dataM = [NSMutableArray array];
//        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [dataM addObject:[SLHeadLineModel headLineWithDict:obj]];
//        }];
        for (NSDictionary *dict in data) {
            SLHeadLineModel *model = [SLHeadLineModel headLineWithDict:dict];
            [dataM addObject:model];
        }
        success(dataM.copy);
        
    } error:^(NSError *errInfo) {
        success(nil);
    }];
}
@end
