//
//  LYDContentPageViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/6/15.
//

#import "LYDContentPageViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYDContentPageViewController () <LYContentPageDelegate, LYContentPageContentDelegate, LYContentPageVideoDelegate>
@property (nonatomic, strong) LYContentPage * contentPage;
@end

@implementation LYDContentPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LYDLocalizedString(@"内容页（视频内容）")];
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *contentpageId = [mmkv getStringForKey:@"contentpageId"];
#ifdef DEBUG
    if (!contentpageId || contentpageId.length == 0) {
        contentpageId = ly_contentpage_id;
    }
#endif
    self.textField.text = contentpageId;
}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    NSString *contentpageId = self.textField.text;
    MMKV *mmkv = [MMKV defaultMMKV];
    [mmkv setString:contentpageId forKey:@"contentpageId"];
    CGRect frame = CGRectMake(10, self.y + 10, self.view.bounds.size.width - 20, self.view.bounds.size.height - self.y - 20);
    self.contentPage = [[LYContentPage alloc] initWithSlotId:contentpageId];
    self.contentPage.delegate = self;
    self.contentPage.contentDelegate = self;
    self.contentPage.videoDelegate = self;
    UIViewController * vc = self.contentPage.viewController;
    [self addChildViewController:vc];
    vc.view.frame = frame;
    [self.view addSubview:vc.view];
}

#pragma mark - LYContentPageDelegate

- (void)ly_contentPageDidLoad:(LYContentPage *)entryElement {
    NSString *text = [NSString stringWithFormat:@"content|%@|%@|%ld", NSStringFromSelector(_cmd), [LYDUnionTypeTool unionName4unionType:entryElement.unionType], [entryElement eCPM]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_contentPageDidFailToLoad:(LYContentPage *)entryElement error:(NSError *)error {
    NSString *text = [NSString stringWithFormat:@"content|%@|%@", NSStringFromSelector(_cmd), [error debugDescription]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

#pragma mark - LYContentPageContentDelegate

- (void)ly_contentPageContentDidFullDisplay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    NSString *text = [NSString stringWithFormat:@"content|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_contentPageContentDidEndDisplay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    NSString *text = [NSString stringWithFormat:@"content|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_contentPageContentDidPause:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    NSString *text = [NSString stringWithFormat:@"content|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_contentPageContentDidResume:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    NSString *text = [NSString stringWithFormat:@"content|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

#pragma mark - LYContentPageVideoDelegate

- (void)ly_contentPageVideoDidStartPlay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    NSString *text = [NSString stringWithFormat:@"content|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_contentPageVideoDidPause:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    NSString *text = [NSString stringWithFormat:@"content|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_contentPageVideoDidResume:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    NSString *text = [NSString stringWithFormat:@"content|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_contentPageVideoDidEndPlay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    NSString *text = [NSString stringWithFormat:@"content|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_contentPageVideoDidFailToPlay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo error:(NSError *)error {
    NSString *text = [NSString stringWithFormat:@"content|%@|%@", NSStringFromSelector(_cmd), [error debugDescription]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

@end
