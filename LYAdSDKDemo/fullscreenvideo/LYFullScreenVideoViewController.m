//
//  LYFullScreenVideoViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/6/16.
//

#import "LYFullScreenVideoViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYFullScreenVideoViewController () <LYFullScreenVideoAdDelegate>
@property (nonatomic, strong) LYFullScreenVideoAd * fullScreenVideoAd;
@end

@implementation LYFullScreenVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"FullScreenVideo", nil)];
    
    self.textField.text = ly_fullscreenvideo_id;
    [self appendLogText:self.title];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load FullScreenVideo"];
    self.textField.enabled = NO;
    if (!self.fullScreenVideoAd) {
        self.fullScreenVideoAd = [[LYFullScreenVideoAd alloc] initWithSlotId:self.textField.text];
        self.fullScreenVideoAd.delegate = self;
    }
    [self.fullScreenVideoAd loadAd];
}

#pragma mark - LYFullScreenVideoAdDelegate

- (void)ly_fullScreenVideoAdDidLoad:(LYFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:[NSString stringWithFormat:@"ly_fullScreenVideoAdDidLoad, unionType: %@", [LYUnionTypeTool unionName4unionType:fullScreenVideoAd.unionType]]];
}

- (void)ly_fullScreenVideoAdDidFailToLoad:(LYFullScreenVideoAd *)fullScreenVideoAd error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"ly_fullScreenVideoAdDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)ly_fullScreenVideoAdDidCache:(LYFullScreenVideoAd *)fullScreenVideoAd {
    BOOL valid = [self.fullScreenVideoAd isValid];
    [self appendLogText:[NSString stringWithFormat:@"ly_fullScreenVideoAdDidCache, isValid: %@", valid ? @"true" : @"false"]];
    [self.fullScreenVideoAd showAdFromRootViewController:self];
}

- (void)ly_fullScreenVideoAdDidExpose:(LYFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:[NSString stringWithFormat:@"ly_fullScreenVideoAdDidExpose, eCPM: %ld", [fullScreenVideoAd eCPM]]];
}

- (void)ly_fullScreenVideoAdDidClick:(LYFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:@"ly_fullScreenVideoAdDidClick"];
}

- (void)ly_fullScreenVideoAdDidClose:(LYFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:@"ly_fullScreenVideoAdDidClose"];
}

- (void)ly_fullScreenVideoAdDidPlayFinish:(LYFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:@"ly_fullScreenVideoAdDidPlayFinish"];
}

- (void)ly_fullScreenVideoAdDidClickSkip:(LYFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:@"ly_fullScreenVideoAdDidClickSkip"];
}

@end
