//
//  LYNativeAdBaseCell.h
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/22.
//

#import <UIKit/UIKit.h>
#import <LYAdSDK/LYAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYNativeAdBaseCell : UITableViewCell
@property (nonatomic, strong) LYNativeAdView *adView;

- (void)setupWithNativeAdDataObject:(LYNativeAdDataObject *)dataObject delegate:(id <LYNativeAdViewDelegate>)delegate vc:(UIViewController *)vc;
+ (CGFloat)cellHeightWithNativeAdDataObject:(LYNativeAdDataObject *)dataObject;
@end

NS_ASSUME_NONNULL_END
