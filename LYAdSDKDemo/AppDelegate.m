//
//  AppDelegate.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/4/27.
//

#import "AppDelegate.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYDMainViewController.h"
#import "LYSlotID.h"
#import "NSBundle+changeBundleId.h"
#import <MMKV/MMKV.h>
#import "KSBulletScreenManager.h"
#import "LYDUnionTypeTool.h"

@interface AppDelegate ()<LYSplashAdDelegate>

@property (nonatomic, strong) UIViewController *logoController;
@property (nonatomic, strong) UINavigationController *rootController;
    
@property (nonatomic, strong) LYSplashAd * splashAd;
@property (nonatomic, assign) NSTimeInterval lastActiveTime;
@property (nonatomic, assign) BOOL didEnterBackground;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [MMKV initializeMMKV:nil];
    
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *fakeBundleId = [mmkv getStringForKey:@"fakeBundleId"];
    NSLog(@"fakeBundleId: %@", fakeBundleId);
    //模拟包名
    [[NSBundle mainBundle] changeBundleIdentifier:(fakeBundleId && fakeBundleId.length > 0) ? fakeBundleId : nil];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LYDMainViewController *main = [[LYDMainViewController alloc] init];
    self.rootController = [[UINavigationController alloc] initWithRootViewController:main];
    
    UIStoryboard* launchScreen = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
    self.logoController = [launchScreen instantiateInitialViewController];
    self.logoController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    self.window.rootViewController = self.logoController;
    [self.window makeKeyAndVisible];
    
    BOOL initSwitch = [mmkv getBoolForKey:@"initSwitch"];
    NSString *appId = [mmkv getStringForKey:@"appId"];
    
    if (initSwitch && appId && appId.length > 0) {
        LYAdSDKPrivacyConfig * privacy = [[LYAdSDKPrivacyConfig alloc] init];
        //    privacy.canUseIDFA = NO;
        //    privacy.canUseLocation = NO;
        //    privacy.customIDFA = @"00000000-0000-0000-0000-000000000000";
        //    LYAdSDKLocation * location = [[LYAdSDKLocation alloc] init];
        //    location.latitude = 20.00;
        //    location.longitude = 10.00;
        //    privacy.location = location;
        BOOL splashSwitch = [mmkv getBoolForKey:@"splashSwitch"];
        NSString *userId = [mmkv getStringForKey:@"userId"];
        NSString *splashId = [mmkv getStringForKey:@"splashId"];
        
//        [LYAdSDKConfig enableDefaultAudioSessionSetting:NO];
//        [LYAdSDKConfig disableSplashAdShake:YES];///是否屏蔽摇⼀摇，false或者不赋值，不屏蔽，true屏蔽
        [LYAdSDKConfig setUserId:userId];
        [LYAdSDKConfig initAppId:appId privacy:privacy];
        
//    #ifdef DEBUG
//        if (!splashId || splashId.length == 0) {
//            splashId = ly_splash_id;
//        }
//    #endif
        if (splashSwitch && splashId && splashId.length > 0) {
            CGRect frame = [UIScreen mainScreen].bounds;
            CGRect splashFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
            self.splashAd = [[LYSplashAd alloc] initWithFrame:splashFrame slotId:splashId];
            self.splashAd.tolerateTimeout = 5;
            self.splashAd.viewController = self.rootController;
            self.splashAd.delegate = self;
            [self.splashAd loadAd];
        } else {
            self.window.rootViewController = self.rootController;
        }
    } else {
        self.window.rootViewController = self.rootController;
    }
    self.lastActiveTime = [[NSDate date] timeIntervalSince1970];
    
    NSLog(@"sdkVersion: %@", [LYAdSDKConfig sdkVersion]);
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [LYAdSDKConfig handleOpenUniversalLink:userActivity];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    self.didEnterBackground = YES;
    self.lastActiveTime = [[NSDate date] timeIntervalSince1970];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    //指定一个最小展示间隔
    if (time - self.lastActiveTime >= 60 && self.didEnterBackground) {
        MMKV *mmkv = [MMKV defaultMMKV];
        BOOL splashSwitch = [mmkv getBoolForKey:@"splashSwitch"];
        if (splashSwitch && self.splashAd) {
            [self.splashAd loadAd];
            self.window.rootViewController = self.logoController;
        }
    }
    self.didEnterBackground = NO;
}

#pragma mark - LYSplashAdDelegate

- (void)ly_splashAdDidLoad:(LYSplashAd *)splashAd {
    self.window.rootViewController = self.rootController;
    NSString *text = [NSString stringWithFormat:@"splash|%@|%@|%d", NSStringFromSelector(_cmd), [LYDUnionTypeTool unionName4unionType:splashAd.unionType], [self.splashAd isValid]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
    [self.splashAd showAdInWindow:[UIApplication sharedApplication].keyWindow];
}

- (void)ly_splashAdDidFailToLoad:(LYSplashAd *)splashAd error:(NSError *)error {
    self.window.rootViewController = self.rootController;
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
