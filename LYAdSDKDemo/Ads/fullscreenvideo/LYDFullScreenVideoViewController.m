//
//  LYDFullScreenVideoViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/6/16.
//

#import "LYDFullScreenVideoViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYDFullScreenVideoViewController () <LYFullScreenVideoAdDelegate>
@property (nonatomic, strong) LYFullScreenVideoAd * fullScreenVideoAd;
@end

@implementation LYDFullScreenVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LYDLocalizedString(@"全屏视频")];
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *fullscreenvideoId = [mmkv getStringForKey:@"fullscreenvideoId"];
#ifdef DEBUG
    if (!fullscreenvideoId || fullscreenvideoId.length == 0) {
        fullscreenvideoId = ly_fullscreenvideo_id;
    }
#endif
    self.textField.text = fullscreenvideoId;
}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    if (!self.fullScreenVideoAd) {
        NSString *fullscreenvideoId = self.textField.text;
        MMKV *mmkv = [MMKV defaultMMKV];
        [mmkv setString:fullscreenvideoId forKey:@"fullscreenvideoId"];
        self.fullScreenVideoAd = [[LYFullScreenVideoAd alloc] initWithSlotId:fullscreenvideoId];
        self.fullScreenVideoAd.delegate = self;
    }
    [self.fullScreenVideoAd loadAd];
}

#pragma mark - LYFullScreenVideoAdDelegate

- (void)ly_fullScreenVideoAdDidLoad:(LYFullScreenVideoAd *)fullScreenVideoAd {
    NSString *text = [NSString stringWithFormat:@"fullscreen|%@|%@", NSStringFromSelector(_cmd), [LYDUnionTypeTool unionName4unionType:fullScreenVideoAd.unionType]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_fullScreenVideoAdDidFailToLoad:(LYFullScreenVideoAd *)fullScreenVideoAd error:(NSError *)error {
    NSString *text = [NSString stringWithFormat:@"fullscreen|%@|%@", NSStringFromSelector(_cmd), [error debugDescription]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_fullScreenVideoAdDidCache:(LYFullScreenVideoAd *)fullScreenVideoAd {
    NSString *text = [NSString stringWithFormat:@"fullscreen|%@|%d", NSStringFromSelector(_cmd), [self.fullScreenVideoAd isValid]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
    [self.fullScreenVideoAd showAdFromRootViewController:self];
}

- (void)ly_fullScreenVideoAdDidExpose:(LYFullScreenVideoAd *)fullScreenVideoAd {
    NSString *text = [NSString stringWithFormat:@"fullscreen|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_fullScreenVideoAdDidClick:(LYFullScreenVideoAd *)fullScreenVideoAd {
    NSString *text = [NSString stringWithFormat:@"fullscreen|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_fullScreenVideoAdDidClose:(LYFullScreenVideoAd *)fullScreenVideoAd {
    NSString *text = [NSString stringWithFormat:@"fullscreen|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_fullScreenVideoAdDidPlayFinish:(LYFullScreenVideoAd *)fullScreenVideoAd {
    NSString *text = [NSString stringWithFormat:@"fullscreen|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_fullScreenVideoAdDidClickSkip:(LYFullScreenVideoAd *)fullScreenVideoAd {
    NSString *text = [NSString stringWithFormat:@"fullscreen|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

@end
