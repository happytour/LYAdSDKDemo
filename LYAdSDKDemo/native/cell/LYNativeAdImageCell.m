//
//  LYNativeAdImageCell.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/22.
//

#import "LYNativeAdImageCell.h"

@implementation LYNativeAdImageCell

- (void)setupWithNativeAdDataObject:(LYNativeAdDataObject *)dataObject delegate:(id <LYNativeAdViewDelegate>)delegate vc:(UIViewController *)vc {
    self.adView.delegate = delegate; // adView 广告回调
    self.adView.viewController = vc; // 跳转 VC
    //一定要先refreshData
    [self.adView refreshData:dataObject];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - 20;
    CGFloat bannerHeigh = 52;
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    if (dataObject.iconUrl) {
        NSURL *iconURL = [NSURL URLWithString:dataObject.iconUrl];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *iconData = [NSData dataWithContentsOfURL:iconURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                iconImageView.image = [UIImage imageWithData:iconData];
            });
        });
    }
    [self.adView addSubview:iconImageView];
    iconImageView.frame = CGRectMake(0, 0, bannerHeigh, bannerHeigh);
    iconImageView.backgroundColor = [UIColor clearColor];
    CGFloat height = bannerHeigh;
    int th = 17;
    {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(height, 0, width - height, 17)];
        title.text = dataObject.title;
        title.font = [UIFont boldSystemFontOfSize:14];
        title.textColor = [UIColor blackColor];
        title.numberOfLines = 1;
        [self.adView addSubview:title];
    }
    {
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(height, th, width - height, height - th)];
        desc.text = dataObject.desc;
        desc.font = [UIFont systemFontOfSize:14];
        desc.textColor = [UIColor blackColor];
        desc.numberOfLines = 0;
        [self.adView addSubview:desc];
    }
    self.adView.frame = CGRectMake(0, 0, width, bannerHeigh);
    self.adView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
    self.adView.logoView.frame = CGRectMake(CGRectGetWidth(self.adView.frame) - self.adView.logoImageViewDefaultWidth, CGRectGetHeight(self.adView.frame) - self.adView.logoImageViewDefaultHeight, self.adView.logoImageViewDefaultWidth, self.adView.logoImageViewDefaultHeight);
    [self.adView addSubview:self.adView.logoView];
    [self.adView registerDataObjectWithClickableViews:@[iconImageView, self.adView]];
}

+ (CGFloat)cellHeightWithNativeAdDataObject:(LYNativeAdDataObject *)dataObject {
    return 52;
}

@end
