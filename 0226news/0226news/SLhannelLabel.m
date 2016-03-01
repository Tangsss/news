//
//  SLhannelLabel.m
//  0226news
//
//  Created by Tang on 16/3/1.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import "SLhannelLabel.h"
#define SLBigFont 18.0
#define SLNomalFont 14.0
@implementation SLhannelLabel

+ (instancetype)channelLabelWithTitle:(NSString *)title
{
    SLhannelLabel *label = [[self alloc]init];
    //设置标题
    label.text = title;
    //设置最大字体
    label.font = [UIFont systemFontOfSize:SLBigFont];
    //算出大小
    [label sizeToFit];
    //设置默认字体
    label.font = [UIFont systemFontOfSize:SLNomalFont];
    //打开用户交互
    label.userInteractionEnabled = YES;
    //居中
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.clickChannel) {
        self.clickChannel();
    }
}

- (void)setScale:(CGFloat)scale
{
    CGFloat percen = (CGFloat)(SLBigFont - SLNomalFont) / SLNomalFont;
    
    percen = percen * scale + 1;
    
    self.transform = CGAffineTransformMakeScale(percen, percen);
    
    self.textColor = [UIColor colorWithRed:percen * scale green:0 blue:0 alpha:YES];
}
@end
