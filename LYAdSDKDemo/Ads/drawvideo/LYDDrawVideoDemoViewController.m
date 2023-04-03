//
//  LYDDrawVideoDemoViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "LYDDrawVideoDemoViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"
#import "LYDDrawVideoAdCell.h"
#import "LYDUnionTypeTool.h"
#import "KSBulletScreenManager.h"

@interface LYDDrawVideoDemoViewController () <LYDrawVideoAdDelegate, LYDrawVideoAdRelatedViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) LYDrawVideoAd * drawVideoAd;
@property (strong, nonatomic) NSMutableArray<LYDrawVideoAdRelatedView *> *drawVideoAdRelatedViews;
@end

@implementation LYDDrawVideoDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.pagingEnabled = YES;
    self.tableView.scrollsToTop = NO;
#if defined(__IPHONE_11_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
#else
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    [self.tableView registerClass:[LYDDrawVideoAdCell class] forCellReuseIdentifier:@"LYDDrawVideoAdCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.drawVideoAdRelatedViews = [NSMutableArray new];
    
    self.drawVideoAd = [[LYDrawVideoAd alloc] initWithSlotId:self.slotId adSize:[[UIScreen mainScreen] bounds].size];
    self.drawVideoAd.delegate = self;
    [self.drawVideoAd loadAdWithCount:3];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button.layer setCornerRadius:10.0];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(13, 34, 100, 50);
    [button setTitle:LYDLocalizedString(@"关闭") forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
    [button addTarget:self action:@selector(closeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:button];
    [self.view addSubview:button];
}

- (void)closeVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UIScreen mainScreen] bounds].size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.drawVideoAdRelatedViews.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        UITableViewCell * cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = LYDLocalizedString(@"测试占位往下滑是广告");
        return cell;
    } else {
        id model = self.drawVideoAdRelatedViews[indexPath.row / 2];
        LYDDrawVideoAdCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"LYDDrawVideoAdCell"];
        [cell refreshWithDrawVideoAdRelatedView:model];
        return cell;
    }
}

#pragma mark - LYDrawVideoAdDelegate

- (void)ly_drawVideoAdDidLoad:(NSArray<LYDrawVideoAdRelatedView *> * _Nullable) drawVideoAdRelatedViews error:(NSError * _Nullable) error {
    if (error) {
        NSString *text = [NSString stringWithFormat:@"draw|%@|%@", NSStringFromSelector(_cmd), [error debugDescription]];
        [[KSBulletScreenManager sharedInstance] showWithText:text];
    } else {
        NSString *text = [NSString stringWithFormat:@"draw|%@|%@", NSStringFromSelector(_cmd), [LYDUnionTypeTool unionName4unionType:self.drawVideoAd.unionType]];
        [[KSBulletScreenManager sharedInstance] showWithText:text];
        [self.drawVideoAdRelatedViews addObjectsFromArray:drawVideoAdRelatedViews];
        if (drawVideoAdRelatedViews.count) {
            [drawVideoAdRelatedViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LYDrawVideoAdRelatedView *relatedView = (LYDrawVideoAdRelatedView *)obj;
                relatedView.delegate = self;
                relatedView.viewController = self;
            }];
        }
        [self.tableView reloadData];
    }
}

#pragma mark - LYDrawVideoAdRelatedViewDelegate

- (void)ly_drawVideoAdRelatedViewDidExpose:(LYDrawVideoAdRelatedView *)drawVideoAdRelatedView {
    NSString *text = [NSString stringWithFormat:@"draw|%@|%ld", NSStringFromSelector(_cmd), [self.drawVideoAd eCPM]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_drawVideoAdRelatedViewDidClick:(LYDrawVideoAdRelatedView *)drawVideoAdRelatedView {
    NSString *text = [NSString stringWithFormat:@"draw|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_drawVideoAdRelatedViewDidCloseOtherController:(LYDrawVideoAdRelatedView *)drawVideoAdRelatedView {
    NSString *text = [NSString stringWithFormat:@"draw|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_drawVideoAdRelatedViewDidPlayFinish:(LYDrawVideoAdRelatedView *)drawVideoAdRelatedView {
    NSString *text = [NSString stringWithFormat:@"draw|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}


@end
