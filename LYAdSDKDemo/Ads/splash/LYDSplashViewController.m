//
//  LYDSplashViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/10.
//

#import "LYDSplashViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYDSplashViewController ()<LYSplashAdDelegate>

@property (nonatomic, strong) LYSplashAd * splashAd;

@end

@implementation LYDSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LYDLocalizedString(@"开屏")];
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *splashId = [mmkv getStringForKey:@"splashId"];
#ifdef DEBUG
    if (!splashId || splashId.length == 0) {
        splashId = ly_splash_id;
    }
#endif
    self.textField.text = splashId;
}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    CGRect frame = [UIScreen mainScreen].bounds;
    CGRect splashFrame = CGRectMake(0, 0, frame.size.width, frame.size.height - 100);
    
    CGRect bottomFrame = CGRectMake(0, frame.size.height - 100, frame.size.width, 100);
    UILabel *bottomView = [[UILabel alloc] initWithFrame:bottomFrame];
    [bottomView setText:@"这是一个测试LOGO"];
    bottomView.backgroundColor = [UIColor redColor];
    if (!self.splashAd) {
        NSString *splashId = self.textField.text;
        MMKV *mmkv = [MMKV defaultMMKV];
        [mmkv setString:splashId forKey:@"splashId"];
        self.splashAd = [[LYSplashAd alloc] initWithFrame:splashFrame slotId:splashId];
        self.splashAd.delegate = self;
        self.splashAd.customBottomView = bottomView;
        self.splashAd.viewController = self;
    }
    [self.splashAd loadAd];
}

#pragma mark - LYSplashAdDelegate

- (void)ly_splashAdDidLoad:(LYSplashAd *)splashAd {
    NSString *text = [NSString stringWithFormat:@"splash|%@|%@|%d", NSStringFromSelector(_cmd), [LYDUnionTypeTool unionName4unionType:splashAd.unionType], [self.splashAd isValid]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
    [self.splashAd showAdInWindow:[UIApplication sharedApplication].keyWindow];
}

- (void)ly_splashAdDidFailToLoad:(LYSplashAd *)splashAd error:(NSError *)error {
    NSString *text = [NSString stringWithFormat:@"splash|%@|%@", NSStringFromSelector(_cmd), [error debugDescription]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_splashAdDidPresent:(LYSplashAd *)splashAd {
    NSString *text = [NSString stringWithFormat:@"splash|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_splashAdDidExpose:(LYSplashAd *)splashAd {
    NSString *text = [NSString stringWithFormat:@"splash|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_splashAdDidClick:(LYSplashAd *)splashAd {
    NSString *text = [NSString stringWithFormat:@"splash|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_splashAdWillClose:(LYSplashAd *)splashAd {
    NSString *text = [NSString stringWithFormat:@"splash|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_splashAdDidClose:(LYSplashAd *)splashAd {
    NSString *text = [NSString stringWithFormat:@"splash|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_splashAdLifeTime:(LYSplashAd *)splashAd time:(NSUInteger)time {
    NSString *text = [NSString stringWithFormat:@"splash|%@|%d", NSStringFromSelector(_cmd), (int)time];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_splashAdDidCloseOtherController:(LYSplashAd *)splashAd {
    NSString *text = [NSString stringWithFormat:@"splash|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

@end
