//
//  LYEntryElementViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "LYEntryElementViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"
#import "LYContentPageFullViewController.h"

@interface LYEntryElementViewController ()<LYEntryElementDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) LYEntryElement * entryElement;

@property (strong, nonatomic) NSMutableArray<LYEntryElement *> *entryElements;
@end

@implementation LYEntryElementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"EntryElement", nil)];
    
    self.textField.text = ly_entryelement_id;
    [self appendLogText:self.title];
    
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
    [self appendLogText:@"load EntryElementAd"];
    self.textField.enabled = NO;
    if (!self.entryElement) {
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - 20;
        self.entryElement = [[LYEntryElement alloc] initWithSlotId:self.textField.text];
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
    [self appendLogText:@"ly_entryElementAdDidLoad"];
    [self.entryElements addObject:entryElement];
    [self.tableView reloadData];
}

- (void)ly_entryElementAdDidFailToLoad:(LYEntryElement *)entryElement error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"ly_entryElementAdDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)ly_entryElementAdDidExpose:(LYEntryElement *)entryElement {
    [self appendLogText:[NSString stringWithFormat:@"ly_entryElementAdDidExpose, unionType: %@", [LYUnionTypeTool unionName4unionType:entryElement.unionType]]];
}

- (void)ly_entryElementAdDidClick:(LYEntryElement *)entryElement contentPage:(LYContentPage *)contentPage {
    [self appendLogText:@"ly_entryElementAdDidClick"];
    
    LYContentPageFullViewController *vc = [[LYContentPageFullViewController alloc] initWithContentPage:contentPage];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
