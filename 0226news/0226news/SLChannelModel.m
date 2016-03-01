//
//  SLChannelModel.m
//  0226news
//
//  Created by Tang on 16/3/1.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import "SLChannelModel.h"
#import <YYModel.h>

@implementation SLChannelModel
+ (NSArray *)channelDatas
{
    //文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    //取出数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    //解析json
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    //取出第一个key
    NSString *key = result.keyEnumerator.nextObject;
    //取出json中的数组数据
    NSArray *array = result[key];
    
    //转成模型返回数组
    return [NSArray yy_modelArrayWithClass:self json:array];
}
@end
