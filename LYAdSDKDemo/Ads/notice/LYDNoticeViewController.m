//
//  LYDNoticeViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/18.
//

#import "LYDNoticeViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYDNoticeViewController ()<LYNoticeAdDelegate>
@property (nonatomic, strong) LYNoticeAd * noticeAd;
@end

@implementation LYDNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LYDLocalizedString(@"通知")];
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *noticeId = [mmkv getStringForKey:@"noticeId"];
#ifdef DEBUG
    if (!noticeId || noticeId.length == 0) {
        noticeId = ly_notice_id;
    }
#endif
    self.textField.text = noticeId;
}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    if (!self.noticeAd) {
        NSString *noticeId = self.textField.text;
        MMKV *mmkv = [MMKV defaultMMKV];
        [mmkv setString:noticeId forKey:@"noticeId"];
        self.noticeAd = [[LYNoticeAd alloc] initWithSlotId:noticeId];
        self.noticeAd.delegate = self;
    }
    [self.noticeAd loadAd];
}

#pragma mark - LYNoticeAdDelegate

- (void)ly_noticeAdDidLoad:(LYNoticeAd *)noticeAd {
    NSString *text = [NSString stringWithFormat:@"notice|%@|%@", NSStringFromSelector(_cmd), [LYDUnionTypeTool unionName4unionType:noticeAd.unionType]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
    [self.noticeAd showAdInWindow:[UIApplication sharedApplication].keyWindow];
}

- (void)ly_noticeAdDidFailToLoad:(LYNoticeAd *)noticeAd error:(NSError *)error {
    NSString *text = [NSString stringWithFormat:@"notice|%@|%@", NSStringFromSelector(_cmd), [error debugDescription]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_noticeAdDidExpose:(LYNoticeAd *)noticeAd {
    NSString *text = [NSString stringWithFormat:@"notice|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_noticeAdDidClick:(LYNoticeAd *)noticeAd {
    NSString *text = [NSString stringWithFormat:@"notice|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_noticeAdDidClose:(LYNoticeAd *)noticeAd {
    NSString *text = [NSString stringWithFormat:@"notice|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

@end
