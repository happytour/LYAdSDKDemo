//
//  LYNativeExpressViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/17.
//

#import "LYNativeExpressViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"

@interface LYNativeExpressViewController ()<LYNativeExpressAdDelegate, LYNativeExpressAdRelatedViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) LYNativeExpressAd * nativeExpressAd;

@property (strong, nonatomic) NSMutableArray<LYNativeExpressAdRelatedView *> *expressAdRelatedViews;
@end

@implementation LYNativeExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"NativeExpress", nil)];
    
    self.textField.text = ly_nativexpress_id;
    [self appendLogText:self.title];
    
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
    [self appendLogText:@"load NativeExpressAd"];
    self.textField.enabled = NO;
    if (!self.nativeExpressAd) {
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - 20;
        self.nativeExpressAd = [[LYNativeExpressAd alloc] initWithSlotId:self.textField.text adSize:CGSizeMake(width, 0)];
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
        [self appendLogText:[NSString stringWithFormat:@"ly_nativeExpressAdDidLoad, error:%@,%@", error.domain, error.localizedDescription]];
    } else {
        [self appendLogText:[NSString stringWithFormat:@"ly_nativeExpressAdDidLoad, unionType: %@", [LYUnionTypeTool unionName4unionType:self.nativeExpressAd.unionType]]];
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
    [self appendLogText:@"ly_nativeExpressAdRelatedViewDidRenderSuccess"];
}

- (void)ly_nativeExpressAdRelatedViewDidRenderFail:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self.expressAdRelatedViews removeObject:nativeExpressAdRelatedView];
    [self.tableView reloadData];
    [self appendLogText:@"ly_nativeExpressAdRelatedViewDidRenderFail"];
}

- (void)ly_nativeExpressAdRelatedViewDidExpose:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self appendLogText:@"ly_nativeExpressAdRelatedViewDidExpose"];
}

- (void)ly_nativeExpressAdRelatedViewDidClick:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self appendLogText:@"ly_nativeExpressAdRelatedViewDidClick"];
}

- (void)ly_nativeExpressAdRelatedViewDidCloseOtherController:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self appendLogText:@"ly_nativeExpressAdRelatedViewDidCloseOtherController"];
}

- (void)ly_nativeExpressAdRelatedViewDislike:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self.expressAdRelatedViews removeObject:nativeExpressAdRelatedView];
    [self.tableView reloadData];
    [self appendLogText:@"ly_nativeExpressAdRelatedViewDislike"];
}

@end
