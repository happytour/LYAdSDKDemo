//
//  LYContentPageFullViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "LYContentPageFullViewController.h"

@interface LYContentPageFullViewController () <LYContentPageDelegate, LYContentPageContentDelegate, LYContentPageVideoDelegate>
@property (nonatomic, strong) LYContentPage * contentPage;
@end

@implementation LYContentPageFullViewController

- (instancetype)initWithContentPage:(LYContentPage *) contentPage {
    if (self = [super init]) {
        self.contentPage = contentPage;
        self.contentPage.delegate = self;
        self.contentPage.contentDelegate = self;
        self.contentPage.videoDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewController:self.contentPage.viewController];
    [self.view addSubview:self.contentPage.viewController.view];
    self.contentPage.viewController.view.frame = self.view.frame;
}

#pragma mark - LYContentPageDelegate

- (void)ly_contentPageDidLoad:(LYContentPage *)entryElement {
    
}

- (void)ly_contentPageDidFailToLoad:(LYContentPage *)entryElement error:(NSError *)error {
    
}

#pragma mark - LYContentPageContentDelegate

- (void)ly_contentPageContentDidFullDisplay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    
}

- (void)ly_contentPageContentDidEndDisplay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    
}

- (void)ly_contentPageContentDidPause:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    
}

- (void)ly_contentPageContentDidResume:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    
}

#pragma mark - LYContentPageVideoDelegate

- (void)ly_contentPageVideoDidStartPlay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    
}

- (void)ly_contentPageVideoDidPause:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    
}

- (void)ly_contentPageVideoDidResume:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    
}

- (void)ly_contentPageVideoDidEndPlay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo {
    
}

- (void)ly_contentPageVideoDidFailToPlay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo error:(NSError *)error {
    
}

@end
