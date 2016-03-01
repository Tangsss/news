//
//  SLHeadLineCell.m
//  0226news
//
//  Created by Tang on 16/2/28.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import "SLHeadLineCell.h"
#import <UIImageView+WebCache.h>
#import "SLHeadLineModel.h"

@interface SLHeadLineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;


@end
@implementation SLHeadLineCell

- (void)setHeadLineMoldel:(SLHeadLineModel *)headLineMoldel
{
    _headLineMoldel = headLineMoldel;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:headLineMoldel.imgsrc]];
}
@end
