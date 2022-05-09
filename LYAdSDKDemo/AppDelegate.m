//
//  AppDelegate.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/4/27.
//

#import "AppDelegate.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LogoViewController.h"
#import "MainViewController.h"
#import "LYSlotID.h"
#import "NSBundle+changeBundleId.h"

@interface AppDelegate ()<LYSplashAdDelegate>

@property (nonatomic, strong) LogoViewController *logoController;
@property (nonatomic, strong) UINavigationController *rootController;
    
@property (nonatomic, strong) LYSplashAd * splashAd;
@property (nonatomic, assign) NSTimeInterval lastActiveTime;
@property (nonatomic, assign) BOOL didEnterBackground;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *fakeBundleId = [defaults objectForKey:@"fakeBundleId"];
    NSLog(@"fakeBundleId: %@", fakeBundleId);
    //模拟包名
    [[NSBundle mainBundle] changeBundleIdentifier:(fakeBundleId && fakeBundleId.length > 0) ? fakeBundleId : nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor grayColor];
    MainViewController *main = [[MainViewController alloc] init];
    self.rootController = [[UINavigationController alloc] initWithRootViewController:main];
    self.logoController = [[LogoViewController alloc] init];
    
    self.window.rootViewController = self.logoController;
    [self.window makeKeyAndVisible];
    
    
    LYAdSDKPrivacyConfig * privacy = [[LYAdSDKPrivacyConfig alloc] init];
//    privacy.canUseIDFA = NO;
//    privacy.canUseLocation = NO;
//    privacy.customIDFA = @"00000000-0000-0000-0000-000000000000";
//    LYAdSDKLocation * location = [[LYAdSDKLocation alloc] init];
//    location.latitude = 20.00;
//    location.longitude = 10.00;
//    privacy.location = location;
    
    NSString *userId = [defaults objectForKey:@"userId"];
    NSString *appId = [defaults objectForKey:@"appId"];
    
    [LYAdSDKConfig setUserId:userId];
    [LYAdSDKConfig initAppId:appId privacy:privacy];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    CGRect splashFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.splashAd = [[LYSplashAd alloc] initWithFrame:splashFrame slotId:ly_splash_id viewController:self.rootController];
    self.splashAd.delegate = self;
    [self.splashAd loadAd];
    
    self.lastActiveTime = [[NSDate date] timeIntervalSince1970];
    
    NSLog(@"sdkVersion: %@", [LYAdSDKConfig sdkVersion]);
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [LYAdSDKConfig handleOpenUniversalLink:userActivity];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    self.didEnterBackground = YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    //指定一个最小展示间隔
    if (time - self.lastActiveTime >= 60 && self.didEnterBackground) {
        self.lastActiveTime = time;
        [self.splashAd loadAd];
        self.window.rootViewController = self.logoController;
    }
    self.didEnterBackground = NO;
}

#pragma mark - LYSplashAdDelegate

- (void)ly_splashAdDidLoad:(LYSplashAd *)splashAd {
    self.window.rootViewController = self.rootController;
    UIWindow *mainWindow = [self keyWindow];
    [self.splashAd showAdInWindow:mainWindow];
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

- (void)ly_splashAdDidFailToLoad:(LYSplashAd *)splashAd error:(NSError *)error {
    self.window.rootViewController = self.rootController;
}

- (void)ly_splashAdDidExpose:(LYSplashAd *)splashAd {
    
}

- (void)ly_splashAdDidClick:(LYSplashAd *)splashAd {

}

- (void)ly_splashAdDidClose:(LYSplashAd *)splashAd {

}

- (void)ly_splashAdLifeTime:(LYSplashAd *)splashAd time:(NSUInteger)time {
    
}

- (void)ly_splashAdDidCloseOtherController:(LYSplashAd *)splashAd {

}

@end
