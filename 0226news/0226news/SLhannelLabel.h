//
//  SLhannelLabel.h
//  0226news
//
//  Created by Tang on 16/3/1.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLhannelLabel : UILabel
+ (instancetype)channelLabelWithTitle:(NSString *)title;
@property(nonatomic,copy) void(^clickChannel)();
@property(nonatomic,assign) CGFloat scale;///<缩放比例
@end
