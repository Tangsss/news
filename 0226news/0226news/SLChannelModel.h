//
//  SLChannelModel.h
//  0226news
//
//  Created by Tang on 16/3/1.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLChannelModel : NSObject
@property(nonatomic,copy) NSString *tname;///<频道名字
@property(nonatomic,copy) NSString *tid;///<频道id

/**
 *  频道数据
 *
 *  @return 频道的数据
 */
+ (NSArray *)channelDatas;
@end
