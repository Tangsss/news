//
//  SLHeadLineModel.h
//  0226news
//
//  Created by Tang on 16/2/26.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLHeadLineModel : NSObject
@property(nonatomic,copy) NSString *title;///<标题
@property(nonatomic,copy) NSString *imgsrc;///<图片路径

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)headLineWithDict:(NSDictionary *)dict;

/**
 *  加载头条数据
 *
 *  @param url     url
 *  @param success 数据回调
 */
+ (void)headLineDatasWithURL:(NSString *)url success:(void(^)(NSArray *headLines))success;
@end
