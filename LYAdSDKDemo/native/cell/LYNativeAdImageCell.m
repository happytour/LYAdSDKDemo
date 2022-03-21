//
//  LYNativeAdImageCell.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/22.
//

#import "LYNativeAdImageCell.h"

@interface LYNativeAdImageCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *desc;

@end

@implementation LYNativeAdImageCell

- (instancetype) init {
    if (self = [super init]) {
        self.iconImageView = [[UIImageView alloc] init];
        self.title = [[UILabel alloc] init];
        self.desc = [[UILabel alloc] init];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconImageView = [[UIImageView alloc] init];
        self.title = [[UILabel alloc] init];
        self.desc = [[UILabel alloc] init];
    }
    return self;
}

- (void)setupWithNativeAdDataObject:(LYNativeAdDataObject *)dataObject delegate:(id <LYNativeAdViewDelegate>)delegate vc:(UIViewController *)vc {
    self.adView.delegate = delegate; // adView 广告回调
    self.adView.viewController = vc; // 跳转 VC
    //一定要先refreshData
    [self.adView refreshData:dataObject];
    //在refreshData之后添加view
    [self.adView addSubview:self.iconImageView];
    [self.adView addSubview:self.title];
    [self.adView addSubview:self.desc];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - 20;
    CGFloat bannerHeigh = 52;
    
    if (dataObject.iconUrl) {
        NSURL *iconURL = [NSURL URLWithString:dataObject.iconUrl];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *iconData = [NSData dataWithContentsOfURL:iconURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.iconImageView.image = [UIImage imageWithData:iconData];
            });
        });
    }
    self.iconImageView.frame = CGRectMake(0, 0, bannerHeigh, bannerHeigh);
    self.iconImageView.backgroundColor = [UIColor clearColor];
    CGFloat height = bannerHeigh;
    int th = 17;
    {
        self.title.frame = CGRectMake(height, 0, width - height, 17);
        self.title.text = dataObject.title;
        self.title.font = [UIFont boldSystemFontOfSize:14];
        self.title.textColor = [UIColor blackColor];
        self.title.numberOfLines = 1;
    }
    {
        self.desc.frame = CGRectMake(height, th, width - height, height - th);
        self.desc.text = dataObject.desc;
        self.desc.font = [UIFont systemFontOfSize:14];
        self.desc.textColor = [UIColor blackColor];
        self.desc.numberOfLines = 0;
    }
    self.adView.frame = CGRectMake(0, 0, width, bannerHeigh);
    self.adView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
    self.adView.logoView.frame = CGRectMake(CGRectGetWidth(self.adView.frame) - self.adView.logoImageViewDefaultWidth, CGRectGetHeight(self.adView.frame) - self.adView.logoImageViewDefaultHeight, self.adView.logoImageViewDefaultWidth, self.adView.logoImageViewDefaultHeight);
    [self.adView addSubview:self.adView.logoView];
    [self.adView registerDataObjectWithClickableViews:@[self.iconImageView, self.adView]];
}

+ (CGFloat)cellHeightWithNativeAdDataObject:(LYNativeAdDataObject *)dataObject {
    return 52;
}

@end
