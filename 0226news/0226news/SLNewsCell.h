//
//  SLNewsCell.h
//  0226news
//
//  Created by Tang on 16/2/29.
//  Copyright © 2016年 大天朝. All rights reserved.
//
//新闻首页
//http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html


#import <UIKit/UIKit.h>
#import "SLNewsModel.h"

@interface SLNewsCell : UITableViewCell
@property(nonatomic,strong) SLNewsModel *news;

/**
 *  返回cell的重用id
 *
 *  @param news 模型
 *
 *  @return 重用id
 */
+ (NSString *)cellIdentiferWithNews:(SLNewsModel *)news;
+ (CGFloat)cellHightWithNews:(SLNewsModel *)news;

@end
