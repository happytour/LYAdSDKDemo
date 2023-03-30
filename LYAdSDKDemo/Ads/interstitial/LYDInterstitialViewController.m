//
//  LYDInterstitialViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/10.
//

#import "LYDInterstitialViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYDInterstitialViewController ()<LYInterstitialAdDelegate>

@property (nonatomic, strong) LYInterstitialAd * interstitial;

@end

@implementation LYDInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LYDLocalizedString(@"插屏")];
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *interstitialId = [mmkv getStringForKey:@"interstitialId"];
#ifdef DEBUG
    if (!interstitialId || interstitialId.length == 0) {
        interstitialId = ly_interstitial_id;
    }
#endif
    self.textField.text = interstitialId;
}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    if (!self.interstitial) {
        NSString *interstitialId = self.textField.text;
        MMKV *mmkv = [MMKV defaultMMKV];
        [mmkv setString:interstitialId forKey:@"interstitialId"];
        CGSize adSize = CGSizeMake(300, 450);
        self.interstitial = [[LYInterstitialAd alloc] initWithSlotId:interstitialId adSize:adSize];
        self.interstitial.videoMuted = YES; // 自动播放时，是否静音。默认 YES。loadAd 前设置。
        self.interstitial.delegate = self;
    }
    [self.interstitial loadAd];
}

#pragma mark - LYInterstitialAdDelegate

- (void)ly_interstitialAdDidLoad:(LYInterstitialAd *)interstitialAd {
    NSString *text = [NSString stringWithFormat:@"interstitial|%@|%@|%d", NSStringFromSelector(_cmd), [LYDUnionTypeTool unionName4unionType:interstitialAd.unionType], [self.interstitial isValid]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
    [self.interstitial showAdFromRootViewController:self];
}

- (void)ly_interstitialAdDidFailToLoad:(LYInterstitialAd *)interstitialAd error:(NSError *)error {
    NSString *text = [NSString stringWithFormat:@"interstitial|%@|%@", NSStringFromSelector(_cmd), [error debugDescription]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_interstitialAdDidExpose:(LYInterstitialAd *)interstitialAd {
    NSString *text = [NSString stringWithFormat:@"interstitial|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_interstitialAdDidClick:(LYInterstitialAd *)interstitialAd {
    NSString *text = [NSString stringWithFormat:@"interstitial|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_interstitialAdDidClose:(LYInterstitialAd *)interstitialAd {
    NSString *text = [NSString stringWithFormat:@"interstitial|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

@end
