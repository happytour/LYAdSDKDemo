//
//  LYBannerViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/10.
//

#import "LYBannerViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYBannerViewController ()<LYBannerAdViewDelegate>

@property (nonatomic, strong) LYBannerAdView * bannerView;

@end

@implementation LYBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"Banner", nil)];

    self.textField.text = ly_banner_id;
    [self appendLogText:self.title];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load BannerAd"];
    self.textField.enabled = NO;
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat bannerHeigh = screenWidth / 600 * 90;
    CGRect frame = CGRectMake(10, self.y += 10, screenWidth - 20, bannerHeigh);
    if (!self.bannerView) {
        self.bannerView = [[LYBannerAdView alloc] initWithFrame:frame slotId:self.textField.text viewController:self];
        self.bannerView.delegate = self;
        self.bannerView.autoSwitchInterval = 30;
    }
    [self.bannerView loadAd];
}

#pragma mark - LYBannerAdViewDelegate

- (void)ly_bannerAdViewDidLoad:(LYBannerAdView *)bannerAd {
    [self appendLogText:[NSString stringWithFormat:@"ly_bannerAdViewDidLoad, unionType: %@", [LYUnionTypeTool unionName4unionType:bannerAd.unionType]]];
    [self.view addSubview:self.bannerView];
}

- (void)ly_bannerAdViewDidFailToLoad:(LYBannerAdView *)bannerAd error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"ly_bannerAdViewDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)ly_bannerAdViewDidExpose:(LYBannerAdView *)bannerAd {
    [self appendLogText:[NSString stringWithFormat:@"ly_bannerAdViewDidExpose, eCPM: %ld", [bannerAd eCPM]]];
}

- (void)ly_bannerAdViewDidClick:(LYBannerAdView *)bannerAd {
    [self appendLogText:@"ly_bannerAdViewDidClick"];
}

- (void)ly_bannerAdViewDidClose:(LYBannerAdView *)bannerAd {
    [self appendLogText:@"ly_bannerAdViewDidClose"];
}

@end
