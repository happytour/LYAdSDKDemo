//
//  LYRewardVideoViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/10.
//

#import "LYRewardVideoViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYRewardVideoViewController ()<LYRewardVideoAdDelegate, UITextFieldDelegate>

@property (nonatomic, strong) LYRewardVideoAd * rewardedAd;
@property (nonatomic, strong) UITextField *extraTextField;
@end

@implementation LYRewardVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"RewardVideo", nil)];
    
    self.textField.text = ly_reward_id;
    [self appendLogText:self.title];
    
    self.extraTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.y += 10, CGRectGetWidth(self.view.frame) - 20, 50)];
    self.extraTextField.placeholder = @"extra";
    self.extraTextField.returnKeyType = UIReturnKeyDone;
    self.extraTextField.borderStyle = UITextBorderStyleLine;
//    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.extraTextField.delegate = self;
    [self.view addSubview:self.extraTextField];

}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load RewardVideoAd"];
    self.textField.enabled = NO;
    if (!self.rewardedAd) {
        if (self.extraTextField.text && self.extraTextField.text.length > 0) {
            self.rewardedAd = [[LYRewardVideoAd alloc] initWithSlotId:self.textField.text extra:self.extraTextField.text];
        } else {
            self.rewardedAd = [[LYRewardVideoAd alloc] initWithSlotId:self.textField.text];
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
    [self appendLogText:[NSString stringWithFormat:@"ly_rewardVideoAdDidLoad, unionType: %@", [LYUnionTypeTool unionName4unionType:rewardVideoAd.unionType]]];
}

- (void)ly_rewardVideoAdDidFailToLoad:(LYRewardVideoAd *)rewardVideoAd error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"ly_rewardVideoAdDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)ly_rewardVideoAdDidCache:(LYRewardVideoAd *)rewardVideoAd {
    [self appendLogText:@"ly_rewardVideoAdDidCache"];
    [self.rewardedAd showAdFromRootViewController:self];
}

- (void)ly_rewardVideoAdDidExpose:(LYRewardVideoAd *)rewardVideoAd {
    [self appendLogText:@"ly_rewardVideoAdDidExpose"];
}

- (void)ly_rewardVideoAdDidClick:(LYRewardVideoAd *)rewardVideoAd {
    [self appendLogText:@"ly_rewardVideoAdDidClick"];
}

- (void)ly_rewardVideoAdDidClose:(LYRewardVideoAd *)rewardVideoAd {
    [self appendLogText:@"ly_rewardVideoAdDidClose"];
}

- (void)ly_rewardVideoAdDidPlayFinish:(LYRewardVideoAd *)rewardVideoAd {
    [self appendLogText:@"ly_rewardVideoAdDidPlayFinish"];
}

- (void)ly_rewardVideoAdDidRewardEffective:(LYRewardVideoAd *)rewardVideoAd trackUid:(NSString *) trackUid {
    [self appendLogText:[NSString stringWithFormat:@"ly_rewardVideoAdDidRewardEffective, trackUid:%@", trackUid]];
}

@end
