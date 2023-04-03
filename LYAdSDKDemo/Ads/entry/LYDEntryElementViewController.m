//
//  LYDEntryElementViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "LYDEntryElementViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"
#import "LYDContentPageFullViewController.h"

@interface LYDEntryElementViewController ()<LYEntryElementDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) LYEntryElement * entryElement;

@property (strong, nonatomic) NSMutableArray<LYEntryElement *> *entryElements;
@end

@implementation LYDEntryElementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LYDLocalizedString(@"入口组件（视频内容）")];
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *entryelementId = [mmkv getStringForKey:@"entryelementId"];
#ifdef DEBUG
    if (!entryelementId || entryelementId.length == 0) {
        entryelementId = ly_entryelement_id;
    }
#endif
    self.textField.text = entryelementId;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat tableViewY = self.y += 10;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.y, CGRectGetWidth(self.view.frame) - 20, screenHeight - tableViewY - 10) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"entryelementcell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.entryElements = [NSMutableArray new];
}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    if (!self.entryElement) {
        NSString *entryelementId = self.textField.text;
        MMKV *mmkv = [MMKV defaultMMKV];
        [mmkv setString:entryelementId forKey:@"entryelementId"];
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - 20;
        self.entryElement = [[LYEntryElement alloc] initWithSlotId:entryelementId];
        self.entryElement.expectedWidth = width;
        self.entryElement.delegate = self;
    }
    [self.entryElement loadAd];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.entryElements objectAtIndex:indexPath.row].entryExpectedSize.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.entryElements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"entryelementcell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
    if ([subView superview]) {
        [subView removeFromSuperview];
    }
    UIView * view = [self.entryElements objectAtIndex:indexPath.row].entryView;
    view.tag = 1000;
    [cell.contentView addSubview:view];
    return cell;
}

#pragma mark - LYEntryElementDelegate

- (void)ly_entryElementAdDidLoad:(LYEntryElement *)entryElement {
    NSString *text = [NSString stringWithFormat:@"entry|%@|%@", NSStringFromSelector(_cmd), [LYDUnionTypeTool unionName4unionType:entryElement.unionType]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
    [self.entryElements addObject:entryElement];
    [self.tableView reloadData];
}

- (void)ly_entryElementAdDidFailToLoad:(LYEntryElement *)entryElement error:(NSError *)error {
    NSString *text = [NSString stringWithFormat:@"entry|%@|%@", NSStringFromSelector(_cmd), [error debugDescription]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_entryElementAdDidExpose:(LYEntryElement *)entryElement {
    NSString *text = [NSString stringWithFormat:@"entry|%@|%ld", NSStringFromSelector(_cmd), [entryElement eCPM]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_entryElementAdDidClick:(LYEntryElement *)entryElement contentPage:(LYContentPage *)contentPage {
    NSString *text = [NSString stringWithFormat:@"entry|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
    
    LYDContentPageFullViewController *vc = [[LYDContentPageFullViewController alloc] initWithContentPage:contentPage];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
