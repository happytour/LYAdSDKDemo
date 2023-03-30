//
//  LYDBannerViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/10.
//

#import "LYDBannerViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYDBannerViewController ()<LYBannerAdViewDelegate>

@property (nonatomic, strong) LYBannerAdView * bannerView;

@end

@implementation LYDBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LYDLocalizedString(@"BANNER（横幅）")];
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *bannerId = [mmkv getStringForKey:@"bannerId"];
#ifdef DEBUG
    if (!bannerId || bannerId.length == 0) {
        bannerId = ly_banner_id;
    }
#endif
    self.textField.text = bannerId;
}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat bannerHeigh = screenWidth / 600 * 90;
    CGRect frame = CGRectMake(10, self.y += 10, screenWidth - 20, bannerHeigh);
    if (!self.bannerView) {
        NSString *bannerId = self.textField.text;
        MMKV *mmkv = [MMKV defaultMMKV];
        [mmkv setString:bannerId forKey:@"bannerId"];
        self.bannerView = [[LYBannerAdView alloc] initWithFrame:frame slotId:bannerId viewController:self];
        self.bannerView.delegate = self;
        self.bannerView.autoSwitchInterval = 30;
    }
    [self.bannerView loadAd];
}

#pragma mark - LYBannerAdViewDelegate

- (void)ly_bannerAdViewDidLoad:(LYBannerAdView *)bannerAd {
    NSString *text = [NSString stringWithFormat:@"banner|%@|%@", NSStringFromSelector(_cmd), [LYDUnionTypeTool unionName4unionType:bannerAd.unionType]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
    [self.view addSubview:self.bannerView];
}

- (void)ly_bannerAdViewDidFailToLoad:(LYBannerAdView *)bannerAd error:(NSError *)error {
    NSString *text = [NSString stringWithFormat:@"banner|%@|%@", NSStringFromSelector(_cmd), [error debugDescription]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_bannerAdViewDidExpose:(LYBannerAdView *)bannerAd {
    NSString *text = [NSString stringWithFormat:@"banner|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_bannerAdViewDidClick:(LYBannerAdView *)bannerAd {
    NSString *text = [NSString stringWithFormat:@"banner|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_bannerAdViewDidClose:(LYBannerAdView *)bannerAd {
    NSString *text = [NSString stringWithFormat:@"banner|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

@end
