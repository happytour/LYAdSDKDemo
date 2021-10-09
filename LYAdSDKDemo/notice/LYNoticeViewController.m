//
//  LYNoticeViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/18.
//

#import "LYNoticeViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYNoticeViewController ()<LYNoticeAdDelegate>
@property (nonatomic, strong) LYNoticeAd * noticeAd;
@end

@implementation LYNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"Notice", nil)];
    
    self.textField.text = ly_notice_id;
    [self appendLogText:self.title];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load NoticeAd"];
    self.textField.enabled = NO;
    if (!self.noticeAd) {
        self.noticeAd = [[LYNoticeAd alloc] initWithSlotId:self.textField.text];
        self.noticeAd.delegate = self;
    }
    [self.noticeAd loadAd];
}

#pragma mark - LYNoticeAdDelegate

- (void)ly_noticeAdDidLoad:(LYNoticeAd *)noticeAd {
    [self appendLogText:[NSString stringWithFormat:@"ly_noticeAdDidLoad, unionType: %@", [LYUnionTypeTool unionName4unionType:noticeAd.unionType]]];
    [self.noticeAd showAdInWindow:[UIApplication sharedApplication].keyWindow];
}

- (void)ly_noticeAdDidFailToLoad:(LYNoticeAd *)noticeAd error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"ly_noticeAdDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)ly_noticeAdDidExpose:(LYNoticeAd *)noticeAd {
    [self appendLogText:@"ly_noticeAdDidExpose"];
}

- (void)ly_noticeAdDidClick:(LYNoticeAd *)noticeAd {
    [self appendLogText:@"ly_noticeAdDidClick"];
}

- (void)ly_noticeAdDidClose:(LYNoticeAd *)noticeAd {
    [self appendLogText:@"ly_noticeAdDidClose"];
}

@end
