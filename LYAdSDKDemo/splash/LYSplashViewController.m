//
//  LYSplashViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/10.
//

#import "LYSplashViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYSplashViewController ()<LYSplashAdDelegate>

@property (nonatomic, strong) LYSplashAd * splashAd;

@end

@implementation LYSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"Splash", nil)];
    
    self.textField.text = ly_splash_id;
    [self appendLogText:self.title];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load SplashAd"];
    self.textField.enabled = NO;
    CGRect frame = [UIScreen mainScreen].bounds;
    CGRect splashFrame = CGRectMake(0, 0, frame.size.width, frame.size.height - 100);
    if (!self.splashAd) {
        self.splashAd = [[LYSplashAd alloc] initWithFrame:splashFrame slotId:self.textField.text viewController:self];
        self.splashAd.delegate = self;
    }
    [self.splashAd loadAd];
}

- (UIWindow*)keyWindow {
    if ([UIApplication sharedApplication].delegate.window) {
        return [UIApplication sharedApplication].delegate.window;
    } else {
        if (@available(iOS 13.0,*)) {
            UIWindow *keyWindow = nil;
            for (UIWindow *window in [UIApplication sharedApplication].windows) {
                if (window.isKeyWindow) {
                    keyWindow = window;
                    break;
                }
            }
            return keyWindow;
        } else {
            return [UIApplication sharedApplication].keyWindow;
        }
    }
}

#pragma mark - LYSplashAdDelegate

- (void)ly_splashAdDidLoad:(LYSplashAd *)splashAd {
    BOOL valid = [self.splashAd isValid];
    [self appendLogText:[NSString stringWithFormat:@"ly_splashAdDidLoad, unionType: %@, isValid: %@", [LYUnionTypeTool unionName4unionType:splashAd.unionType], valid ? @"true" : @"false"]];
    
    UIWindow *keyWindow = [self keyWindow];
    CGRect frame = [UIScreen mainScreen].bounds;
    CGRect bottomFrame = CGRectMake(0, frame.size.height - 100, frame.size.width, 100);

    UILabel *bottomView = [[UILabel alloc] initWithFrame:bottomFrame];

    [bottomView setText:@"这是一个测试LOGO"];
    bottomView.backgroundColor = [UIColor redColor];
    [self.splashAd showAdInWindow:keyWindow withBottomView:bottomView];
}

- (void)ly_splashAdDidFailToLoad:(LYSplashAd *)splashAd error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"ly_splashAdDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)ly_splashAdDidPresent:(LYSplashAd *)splashAd {
    [self appendLogText:@"ly_splashAdDidPresent"];
}

- (void)ly_splashAdDidExpose:(LYSplashAd *)splashAd {
    [self appendLogText:@"ly_splashAdDidExpose"];
}

- (void)ly_splashAdDidClick:(LYSplashAd *)splashAd {
    [self appendLogText:@"ly_splashAdDidClick"];
}

- (void)ly_splashAdWillClose:(LYSplashAd *)splashAd {
    [self appendLogText:@"ly_splashAdWillClose"];
}

- (void)ly_splashAdDidClose:(LYSplashAd *)splashAd {
    [self appendLogText:@"ly_splashAdDidClose"];
}

- (void)ly_splashAdLifeTime:(LYSplashAd *)splashAd time:(NSUInteger)time {
    [self appendLogText:[NSString stringWithFormat:@"ly_splashAdLifeTime, time:%d", (int)time]];
}

- (void)ly_splashAdDidCloseOtherController:(LYSplashAd *)splashAd {
    [self appendLogText:@"ly_splashAdDidCloseOtherController"];
}

@end
