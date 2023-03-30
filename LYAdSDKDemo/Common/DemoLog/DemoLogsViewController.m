//
//  DemoLogsViewController.m
//  DemoCommon
//
//  Created by jie cai on 2022/3/8.
//

#import "DemoLogsViewController.h"
//#import "KSBaseDemoViewController.h"
//#import "ViewController.h"
#import "DemoLogOperation.h"
#import "Masonry.h"

@interface DemoLogsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray <NSString *> *demoLogFiles;

@end

@implementation DemoLogsViewController

+ (void)load {
//    KSADDemoAction *action = [KSADDemoAction new];
//    action.name = @"导出 DemoLog";
//    action.sectionIndex = KSExportSection;
//    action.actionBlock = ^(KSBaseDemoViewController *vc) {
//        DemoLogsViewController *demoVC = [DemoLogsViewController new];
//        [vc.navigationController pushViewController:demoVC animated:YES];
//    };
//    [ViewController registerAction:action];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.demoLogFiles = [[DemoLogOperation shareLogOperation] listPathDemoLogs];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demoLogFiles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return LYDLocalizedString(@"点击分享");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"DemoLogCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        // 判断是否是暗黑模式
        if (@available(iOS 12.0, *)) {
            BOOL isDark = (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark);
            cell.textLabel.textColor = isDark ? [UIColor whiteColor] : [UIColor blackColor];
        } else {
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }
    NSString *fileName = [self.demoLogFiles objectAtIndex:indexPath.row];
    cell.textLabel.text = fileName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *log = self.demoLogFiles[indexPath.row];
    NSString *fullLogPath = [[DemoLogOperation shareLogOperation] fullPathOfLogfile:log];
    [self airdropWithFile:fullLogPath];
}

- (void)airdropWithFile:(NSString *)file {
    NSURL *fileUrl = [NSURL fileURLWithPath:file];
    NSArray *activityItems = @[fileUrl];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
    // 选中活动列表类型
    [activityViewController setCompletionWithItemsHandler:^(NSString *__nullable activityType, BOOL completed, NSArray *__nullable returnedItems, NSError *__nullable activityError) {
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
