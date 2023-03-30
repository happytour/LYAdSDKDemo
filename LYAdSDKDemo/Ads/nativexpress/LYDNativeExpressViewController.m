//
//  LYDNativeExpressViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/17.
//

#import "LYDNativeExpressViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYDNativeExpressViewController ()<LYNativeExpressAdDelegate, LYNativeExpressAdRelatedViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) LYNativeExpressAd * nativeExpressAd;

@property (strong, nonatomic) NSMutableArray<LYNativeExpressAdRelatedView *> *expressAdRelatedViews;
@end

@implementation LYDNativeExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LYDLocalizedString(@"信息流模版")];
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *nativexpressId = [mmkv getStringForKey:@"nativexpressId"];
#ifdef DEBUG
    if (!nativexpressId || nativexpressId.length == 0) {
        nativexpressId = ly_nativexpress_id;
    }
#endif
    self.textField.text = nativexpressId;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat tableViewY = self.y += 10;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.y, CGRectGetWidth(self.view.frame) - 20, screenHeight - tableViewY - 10) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"nativeexpresscell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.expressAdRelatedViews = [NSMutableArray new];
}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    if (!self.nativeExpressAd) {
        NSString *nativexpressId = self.textField.text;
        MMKV *mmkv = [MMKV defaultMMKV];
        [mmkv setString:nativexpressId forKey:@"nativexpressId"];
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - 20;
        self.nativeExpressAd = [[LYNativeExpressAd alloc] initWithSlotId:nativexpressId adSize:CGSizeMake(width, 0)];
        self.nativeExpressAd.delegate = self;
    }
    [self.nativeExpressAd loadAdWithCount:3];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view = [[self.expressAdRelatedViews objectAtIndex:indexPath.row] getAdView];
    return view.bounds.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.expressAdRelatedViews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"nativeexpresscell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
    if ([subView superview]) {
        [subView removeFromSuperview];
    }
    UIView * view = [[self.expressAdRelatedViews objectAtIndex:indexPath.row] getAdView];
    view.tag = 1000;
    [cell.contentView addSubview:view];
    return cell;
}

#pragma mark - LYNativeExpressAdDelegate

- (void)ly_nativeExpressAdDidLoad:(NSArray<LYNativeExpressAdRelatedView *> * _Nullable)nativeExpressAdRelatedViews error:(NSError * _Nullable)error {
    if (error) {
        NSString *text = [NSString stringWithFormat:@"nativeExpress|%@|%@", NSStringFromSelector(_cmd), [error debugDescription]];
        [[KSBulletScreenManager sharedInstance] showWithText:text];
    } else {
        NSString *text = [NSString stringWithFormat:@"nativeExpress|%@|%@", NSStringFromSelector(_cmd), [LYDUnionTypeTool unionName4unionType:self.nativeExpressAd.unionType]];
        [[KSBulletScreenManager sharedInstance] showWithText:text];
        [self.expressAdRelatedViews addObjectsFromArray:nativeExpressAdRelatedViews];
        if (nativeExpressAdRelatedViews.count) {
            [nativeExpressAdRelatedViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LYNativeExpressAdRelatedView *relatedView = (LYNativeExpressAdRelatedView *)obj;
                relatedView.delegate = self;
                relatedView.viewController = self;
                [relatedView render];
            }];
        }
        [self.tableView reloadData];
    }
}

#pragma mark - LYNativeExpressAdRelatedViewDelegate

- (void)ly_nativeExpressAdRelatedViewDidRenderSuccess:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self.tableView reloadData];
    NSString *text = [NSString stringWithFormat:@"nativeExpress|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_nativeExpressAdRelatedViewDidRenderFail:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self.expressAdRelatedViews removeObject:nativeExpressAdRelatedView];
    [self.tableView reloadData];
    NSString *text = [NSString stringWithFormat:@"nativeExpress|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_nativeExpressAdRelatedViewDidExpose:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    NSString *text = [NSString stringWithFormat:@"nativeExpress|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_nativeExpressAdRelatedViewDidClick:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    NSString *text = [NSString stringWithFormat:@"nativeExpress|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_nativeExpressAdRelatedViewDidCloseOtherController:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    NSString *text = [NSString stringWithFormat:@"nativeExpress|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_nativeExpressAdRelatedViewDislike:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self.expressAdRelatedViews removeObject:nativeExpressAdRelatedView];
    [self.tableView reloadData];
    NSString *text = [NSString stringWithFormat:@"nativeExpress|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

@end
