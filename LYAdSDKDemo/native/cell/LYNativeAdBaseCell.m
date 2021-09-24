//
//  LYNativeAdBaseCell.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/22.
//

#import "LYNativeAdBaseCell.h"

@implementation LYNativeAdBaseCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.adView = [[LYNativeAdView alloc] init];
        [self.contentView addSubview:self.adView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.adView = [[LYNativeAdView alloc] init];
        [self.contentView addSubview:self.adView];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

#pragma mark - public
- (void)setupWithNativeAdDataObject:(LYNativeAdDataObject *)dataObject delegate:(id<LYNativeAdViewDelegate>)delegate vc:(UIViewController *)vc {
}

+ (CGFloat)cellHeightWithNativeAdDataObject:(LYNativeAdDataObject *)dataObject {
    return 0;
}

@end
