//
//  LYDRewardVideoViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/10.
//

#import "LYDRewardVideoViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYDRewardVideoViewController ()<LYRewardVideoAdDelegate, UITextFieldDelegate>

@property (nonatomic, strong) LYRewardVideoAd * rewardedAd;
@property (nonatomic, strong) UITextField *extraTextField;
@end

@implementation LYDRewardVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LYDLocalizedString(@"激励视频")];
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *rewardId = [mmkv getStringForKey:@"rewardId"];
    NSString *rewardExtra = [mmkv getStringForKey:@"rewardExtra"];
#ifdef DEBUG
    if (!rewardId || rewardId.length == 0) {
        rewardId = ly_reward_id;
    }
#endif
    self.textField.text = rewardId;
    self.extraTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.y += 10, CGRectGetWidth(self.view.frame) - 20, 50)];
    self.extraTextField.placeholder = LYDLocalizedString(@"填入extra");
    self.extraTextField.returnKeyType = UIReturnKeyDone;
    self.extraTextField.borderStyle = UITextBorderStyleRoundedRect;
//    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.extraTextField.delegate = self;
    self.extraTextField.text = rewardExtra;
    [self.view addSubview:self.extraTextField];

}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    if (!self.rewardedAd) {
        NSString *rewardId = self.textField.text;
        NSString *rewardExtra = self.extraTextField.text;
        MMKV *mmkv = [MMKV defaultMMKV];
        [mmkv setString:rewardId forKey:@"rewardId"];
        [mmkv setString:rewardExtra forKey:@"rewardExtra"];
        if (rewardExtra && rewardExtra.length > 0) {
            self.rewardedAd = [[LYRewardVideoAd alloc] initWithSlotId:rewardId extra:rewardExtra];
        } else {
            self.rewardedAd = [[LYRewardVideoAd alloc] initWithSlotId:rewardId];
        }
        self.rewardedAd.delegate = self;
    }
    [self.rewardedAd loadAd];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.extraTextField resignFirstResponder];
    return YES;
}

#pragma mark - LYRewardVideoAdDelegate

- (void)ly_rewardVideoAdDidLoad:(LYRewardVideoAd *)rewardVideoAd {
    NSString *text = [NSString stringWithFormat:@"reward|%@|%@|%d", NSStringFromSelector(_cmd), [LYDUnionTypeTool unionName4unionType:rewardVideoAd.unionType], [self.rewardedAd isValid]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_rewardVideoAdDidFailToLoad:(LYRewardVideoAd *)rewardVideoAd error:(NSError *)error {
    NSString *text = [NSString stringWithFormat:@"reward|%@|%@", NSStringFromSelector(_cmd), [error debugDescription]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_rewardVideoAdDidCache:(LYRewardVideoAd *)rewardVideoAd {
    NSString *text = [NSString stringWithFormat:@"reward|%@|%d", NSStringFromSelector(_cmd), [self.rewardedAd isValid]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
    [self.rewardedAd showAdFromRootViewController:self];
}

- (void)ly_rewardVideoAdDidExpose:(LYRewardVideoAd *)rewardVideoAd {
    NSString *text = [NSString stringWithFormat:@"reward|%@|%ld", NSStringFromSelector(_cmd), [rewardVideoAd eCPM]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_rewardVideoAdDidClick:(LYRewardVideoAd *)rewardVideoAd {
    NSString *text = [NSString stringWithFormat:@"reward|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_rewardVideoAdDidClose:(LYRewardVideoAd *)rewardVideoAd {
    NSString *text = [NSString stringWithFormat:@"reward|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_rewardVideoAdDidPlayFinish:(LYRewardVideoAd *)rewardVideoAd {
    NSString *text = [NSString stringWithFormat:@"reward|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_rewardVideoAdDidRewardEffective:(LYRewardVideoAd *)rewardVideoAd trackUid:(NSString *) trackUid {
    NSString *text = [NSString stringWithFormat:@"reward|%@|%@", NSStringFromSelector(_cmd), trackUid];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

@end
