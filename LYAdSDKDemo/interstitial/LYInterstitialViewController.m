//
//  LYInterstitialViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/10.
//

#import "LYInterstitialViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYInterstitialViewController ()<LYInterstitialAdDelegate>

@property (nonatomic, strong) LYInterstitialAd * interstitial;

@end

@implementation LYInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"Interstitial", nil)];
    
    self.textField.text = ly_interstitial_id;
    [self appendLogText:self.title];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load InterstitialAd"];
    self.textField.enabled = NO;
    if (!self.interstitial) {
        CGSize adSize = CGSizeMake(300, 450);
        self.interstitial = [[LYInterstitialAd alloc] initWithSlotId:self.textField.text adSize:adSize];
        self.interstitial.delegate = self;
    }
    [self.interstitial loadAd];
}

#pragma mark - LYInterstitialAdDelegate

- (void)ly_interstitialAdDidLoad:(LYInterstitialAd *)interstitialAd {
    BOOL valid = [self.interstitial isValid];
    [self appendLogText:[NSString stringWithFormat:@"ly_interstitialAdDidLoad, unionType: %@, isValid: %@", [LYUnionTypeTool unionName4unionType:interstitialAd.unionType], valid ? @"true" : @"false"]];
    [self.interstitial showAdFromRootViewController:self];
}

- (void)ly_interstitialAdDidFailToLoad:(LYInterstitialAd *)interstitialAd error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"ly_interstitialAdDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)ly_interstitialAdDidExpose:(LYInterstitialAd *)interstitialAd {
    [self appendLogText:@"ly_interstitialAdDidExpose"];
}

- (void)ly_interstitialAdDidClick:(LYInterstitialAd *)interstitialAd {
    [self appendLogText:@"ly_interstitialAdDidClick"];
}

- (void)ly_interstitialAdDidClose:(LYInterstitialAd *)interstitialAd {
    [self appendLogText:@"ly_interstitialAdDidClose"];
}

@end
