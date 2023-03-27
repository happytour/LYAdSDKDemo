//
//  LYContentPageViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/6/15.
//

#import "LYContentPageViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYContentPageViewController () <LYContentPageDelegate, LYContentPageContentDelegate, LYContentPageVideoDelegate>
@property (nonatomic, strong) LYContentPage * contentPage;
@end

@implementation LYContentPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"ContentPage", nil)];
    
    self.textField.text = ly_contentpage_id;
    [self appendLogText:self.title];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load ContentPageAd"];
    self.textField.enabled = NO;
    CGRect frame = CGRectMake(10, self.y + 10, self.view.bounds.size.width - 20, self.view.bounds.size.height - self.y - 20);
    self.contentPage = [[LYContentPage alloc] initWithSlotId:self.textField.text];
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
    [self appendLogText:[NSString stringWithFormat:@"ly_contentPageDidLoad, unionType: %@", [LYUnionTypeTool unionName4unionType:entryElement.unionType]]];

    [self appendLogText:[NSString stringWithFormat:@"eCPM: %ld", [self.contentPage eCPM]]];
}

- (void)ly_contentPageDidFailToLoad:(LYContentPage *)entryElement error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"ly_contentPageDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

#pragma mark - LYContentPageContentDelegate

- (void)ly_contentPageContentDidFullDisplay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    [self appendLogText:@"ly_contentPageContentDidFullDisplay"];
}

- (void)ly_contentPageContentDidEndDisplay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    [self appendLogText:@"ly_contentPageContentDidEndDisplay"];
}

- (void)ly_contentPageContentDidPause:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    [self appendLogText:@"ly_contentPageContentDidPause"];
}

- (void)ly_contentPageContentDidResume:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    [self appendLogText:@"ly_contentPageContentDidResume"];
}

#pragma mark - LYContentPageVideoDelegate

- (void)ly_contentPageVideoDidStartPlay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    [self appendLogText:@"ly_contentPageVideoDidStartPlay"];
}

- (void)ly_contentPageVideoDidPause:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    [self appendLogText:@"ly_contentPageVideoDidPause"];
}

- (void)ly_contentPageVideoDidResume:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    [self appendLogText:@"ly_contentPageVideoDidResume"];
}

- (void)ly_contentPageVideoDidEndPlay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    [self appendLogText:@"ly_contentPageVideoDidEndPlay"];
}

- (void)ly_contentPageVideoDidFailToPlay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"ly_contentPageVideoDidFailToPlay, error:%@,%@", error.domain, error.localizedDescription]];
}

@end
