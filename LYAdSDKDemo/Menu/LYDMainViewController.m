//
//  LYDMainViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/4/27.
//

#import "LYDMainViewController.h"
#import "LYDConfigViewController.h"
#import "LYDSplashViewController.h"
#import "LYDInterstitialViewController.h"
#import "LYDRewardVideoViewController.h"
#import "LYDBannerViewController.h"
#import "LYDNativeViewController.h"
#import "LYDNativeExpressViewController.h"
#import "LYDNoticeViewController.h"
#import "LYDFullScreenVideoViewController.h"
#import "LYDDrawVideoViewController.h"
#import "LYDContentPageViewController.h"
#import "LYDEntryElementViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "NSBundle+changeBundleId.h"
#import "LYDActionCellView.h"
#import "DemoLogsViewController.h"
#import <MMKV/MMKV.h>
#import "SVProgressHUD.h"

@interface LYDMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray<NSMutableArray *> *items;
@end

@implementation LYDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
    //ios 15系统
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appperance = [[UINavigationBarAppearance alloc]init];
        //添加背景色
        appperance.backgroundColor = titleBGColor;
        appperance.shadowImage = [[UIImage alloc]init];
        appperance.shadowColor = nil;
        //设置字体颜色大小
        [appperance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.navigationController.navigationBar.standardAppearance = appperance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appperance;
        self.navigationController.navigationBar.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        [self.navigationController.navigationBar setBarTintColor:titleBGColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    Class plainActionCellClass = [LYDActionCellView class];
    [self.tableView registerClass:plainActionCellClass forCellReuseIdentifier:NSStringFromClass(plainActionCellClass)];
    
    __weak typeof(self) weakSelf = self;
    LYDActionModel *initAdVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"初始化") type:LYDCellType_init action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self initSDK];
    }];
    LYDActionModel *splashAdVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"开屏") type:LYDCellType_normal action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[LYDSplashViewController alloc] init] sender:nil];
    }];
    LYDActionModel *interstitialAdVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"插屏")  type:LYDCellType_normal action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[LYDInterstitialViewController alloc] init] sender:nil];
    }];
    LYDActionModel *rewardedAdVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"激励视频") type:LYDCellType_normal action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[LYDRewardVideoViewController alloc] init] sender:nil];
    }];
    LYDActionModel *nativeAdVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"信息流自渲染") type:LYDCellType_normal action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[LYDNativeViewController alloc] init] sender:nil];
    }];
    LYDActionModel *nativeExpressAdVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"信息流模版") type:LYDCellType_normal action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[LYDNativeExpressViewController alloc] init] sender:nil];
    }];
    LYDActionModel *bannerAdVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"BANNER（横幅）") type:LYDCellType_normal action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[LYDBannerViewController alloc] init] sender:nil];
    }];
    LYDActionModel *noticeAdVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"通知") type:LYDCellType_normal action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[LYDNoticeViewController alloc] init] sender:nil];
    }];
    LYDActionModel *fullScreenAdVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"全屏视频") type:LYDCellType_normal action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[LYDFullScreenVideoViewController alloc] init] sender:nil];
    }];
    LYDActionModel *drawAdVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"Draw视频（模版视频）") type:LYDCellType_normal action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[LYDDrawVideoViewController alloc] init] sender:nil];
    }];
    LYDActionModel *contentAdVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"内容页（视频内容）") type:LYDCellType_normal action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[LYDContentPageViewController alloc] init] sender:nil];
    }];
    LYDActionModel *entryAdVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"入口组件（视频内容）") type:LYDCellType_normal action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[LYDEntryElementViewController alloc] init] sender:nil];
    }];
    LYDActionModel *demoLogsVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"导出日志") type:LYDCellType_export action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[DemoLogsViewController alloc] init] sender:nil];
    }];
    LYDActionModel *configVc = [LYDActionModel plainTitleActionModel:LYDLocalizedString(@"设置") type:LYDCellType_setting action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[LYDConfigViewController alloc] init] sender:nil];
    }];
    
    self.items = @[
        @[initAdVc],
        @[splashAdVc, interstitialAdVc, rewardedAdVc, nativeAdVc, nativeExpressAdVc, bannerAdVc, noticeAdVc, fullScreenAdVc, drawAdVc, contentAdVc, entryAdVc],
        @[demoLogsVc],
        @[configVc]
    ];
    
    CGFloat height = 22 * self.items.count;
    for (NSArray *subItem in self.items) {
        height += 44 * subItem.count;
    }
    height += 30;
    UILabel *versionLable = [[UILabel alloc]initWithFrame:CGRectMake(0, height, self.tableView.frame.size.width, 40)];
    versionLable.textAlignment = NSTextAlignmentCenter;
    versionLable.text = [NSString stringWithFormat:@"v%@",[LYAdSDKConfig sdkVersion]];
    versionLable.textColor = [UIColor grayColor];
    [self.tableView addSubview:versionLable];
}

- (void)initSDK {
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *appId = [mmkv getStringForKey:@"appId"];
    if (appId && appId.length > 0) {
        LYAdSDKPrivacyConfig * privacy = [[LYAdSDKPrivacyConfig alloc] init];
        //    privacy.canUseIDFA = NO;
        //    privacy.canUseLocation = NO;
        //    privacy.customIDFA = @"00000000-0000-0000-0000-000000000000";
        //    LYAdSDKLocation * location = [[LYAdSDKLocation alloc] init];
        //    location.latitude = 20.00;
        //    location.longitude = 10.00;
        //    privacy.location = location;
        NSString *userId = [mmkv getStringForKey:@"userId"];
        [LYAdSDKConfig setUserId:userId];
        [LYAdSDKConfig initAppId:appId privacy:privacy];
        
        [SVProgressHUD showSuccessWithStatus:LYDLocalizedString(@"初始化成功")];
    } else {
        [SVProgressHUD showErrorWithStatus:LYDLocalizedString(@"appId不能为空")];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionItems = self.items[section];
    return sectionItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionItems = self.items[indexPath.section];
    LYDActionModel *model = sectionItems[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LYDActionCellView" forIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(LYDActionCellConfig)]) {
        [(id<LYDActionCellConfig>)cell configWithModel:model];
    } else {
        cell = [UITableViewCell new];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<LYDCommandProtocol> *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(LYDCommandProtocol)]) {
        [cell execute];
    }
}

@end
