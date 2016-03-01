//
//  SLNewsCell.m
//  0226news
//
//  Created by Tang on 16/2/29.
//  Copyright © 2016年 大天朝. All rights reserved.
//

#import "SLNewsCell.h"
#import <UIImageView+WebCache.h>


@interface SLNewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgextra;//多个图片视图


@end
@implementation SLNewsCell

- (void)setNews:(SLNewsModel *)news
{
    _news = news;
    //设置属性
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageDownloaderLowPriority];
    
    self.titleLabel.text = news.title;
    self.digestLabel.text = news.digest;
//    NSLog(@"%@",self.digestLabel.text);
    self.replyCountLabel.text = [NSString stringWithFormat:@"%@人已跟帖",news.replyCount];
    
    //判断是否更多图片
    if (_news.imgextra != nil) {
        //设置更多图片
        [self.imgextra enumerateObjectsUsingBlock:^(UIImageView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //取出对应的图片
            SLNewsImageModel *model = news.imgextra[idx];
            
            [obj sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageDownloaderLowPriority];
        }];
    }
}

+ (NSString *)cellIdentiferWithNews:(SLNewsModel *)news
{
    if (news.imgextra != nil) {
        return @"SLNewsModelImageCell";
    }else if (news.imgType == 1) {
        return @"SLNewsBigImageCell";
    }else
    {
        return @"SLNewsCell";
    }
}
+ (CGFloat)cellHightWithNews:(SLNewsModel *)news
{
    if (news.imgextra != nil) {
        return 120;
    }else if (news.imgType == 1) {
        return 150;
    }else{
        return 80;
    }
}
@end
