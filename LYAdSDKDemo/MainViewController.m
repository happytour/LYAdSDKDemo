//
//  MainViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/4/27.
//

#import "MainViewController.h"
#import "ConfigViewController.h"
#import "LYSplashViewController.h"
#import "LYInterstitialViewController.h"
#import "LYRewardVideoViewController.h"
#import "LYBannerViewController.h"
#import "LYNativeViewController.h"
#import "LYNativeExpressViewController.h"
#import "LYNoticeViewController.h"
#import "LYFullScreenVideoViewController.h"
#import "LYDrawVideoViewController.h"
#import "LYContentPageViewController.h"
#import "LYEntryElementViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "NSBundle+changeBundleId.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"LYAdSDKDemo"];
    
    UIScrollView *layout = [[UIScrollView alloc] init];
    layout.frame = self.view.bounds;
    [self.view addSubview:layout];
    CGFloat y = -50;
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Config", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnConfig) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *appVersionCode = [infoDictionary objectForKey:@"CFBundleVersion"];
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString *userId = [defaults objectForKey:@"userId"];
        NSString *appId = [defaults objectForKey:@"appId"];
//        NSString *fakeBundleId = [defaults objectForKey:@"fakeBundleId"];
        NSString *fakeBundleId = [NSBundle mainBundle].nowBundleId ? [NSBundle mainBundle].nowBundleId : [NSBundle mainBundle].orgBundleId;
        NSString * log = [NSString stringWithFormat:@"demo version: %@(%@)\nsdk version: %@(%d)\napi version: %ld\nappId: %@\nuserId: %@\n%@: %@", appVersion, appVersionCode, [LYAdSDKConfig sdkVersion], (int)LYAdSDKVersionNumber, [LYAdSDKConfig apiVersion], appId, userId, NSLocalizedString(@"fakeBundleId", nil), fakeBundleId];
        UITextView *logText = [[UITextView alloc] init];
        logText.textColor = UIColor.whiteColor;
        logText.backgroundColor = UIColor.blackColor;
        logText.text = log;
        logText.editable = NO;
        logText.layoutManager.allowsNonContiguousLayout = NO;
        [logText sizeToFit];
        logText.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, logText.bounds.size.height);
        [layout addSubview:logText];
        y += logText.bounds.size.height - 50;
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Splash", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnSplash) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Interstitial", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnInterstitial) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"RewardVideo", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnRewardVideo) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Native", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnNative) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"NativeExpress", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnNativeExpress) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Banner", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnBannerView) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Notice", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnNotice) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"FullScreenVideo", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnFullScreenVideo) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"DrawVideo", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnDrawVideo) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"ContentPage", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnContentPage) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"EntryElement", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnEntryElement) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    layout.contentSize = CGSizeMake(0, y + 60);
}

- (void)clickBtnConfig {
    ConfigViewController *vc = [[ConfigViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnSplash {
    LYSplashViewController *vc = [[LYSplashViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnInterstitial {
    LYInterstitialViewController *vc = [[LYInterstitialViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnRewardVideo {
    LYRewardVideoViewController *vc = [[LYRewardVideoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnNative {
    LYNativeViewController *vc = [[LYNativeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnNativeExpress {
    LYNativeExpressViewController *vc = [[LYNativeExpressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnBannerView {
    LYBannerViewController *vc = [[LYBannerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnNotice {
    LYNoticeViewController *vc = [[LYNoticeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnFullScreenVideo {
    LYFullScreenVideoViewController *vc = [[LYFullScreenVideoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnDrawVideo {
    LYDrawVideoViewController *vc = [[LYDrawVideoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnContentPage {
    LYContentPageViewController *vc = [[LYContentPageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnEntryElement {
    LYEntryElementViewController *vc = [[LYEntryElementViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
