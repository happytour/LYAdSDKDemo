//
//  LYDNativeViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/11.
//

#import "LYDNativeViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"
#import "LYDNativeAdImageCell.h"
#import "LYDNativeAdVideoCell.h"

@interface LYDNativeViewController ()<LYNativeAdDelegate, LYNativeAdViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) LYNativeAd * nativeAd;
@property (nonatomic, strong) NSMutableArray<LYNativeAdDataObject *> *adDataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LYDNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LYDLocalizedString(@"信息流自渲染")];
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *nativeId = [mmkv getStringForKey:@"nativeId"];
#ifdef DEBUG
    if (!nativeId || nativeId.length == 0) {
        nativeId = ly_native_id;
    }
#endif
    self.textField.text = nativeId;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat tableViewY = self.y += 10;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.y, CGRectGetWidth(self.view.frame) - 20, screenHeight - tableViewY - 10) style:UITableViewStylePlain];
    [self.tableView registerClass:[LYDNativeAdImageCell class] forCellReuseIdentifier:@"LYDNativeAdImageCell"];
    [self.tableView registerClass:[LYDNativeAdVideoCell class] forCellReuseIdentifier:@"LYDNativeAdVideoCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.adDataArray = [NSMutableArray new];
}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    if (!self.nativeAd) {
        NSString *nativeId = self.textField.text;
        MMKV *mmkv = [MMKV defaultMMKV];
        [mmkv setString:nativeId forKey:@"nativeId"];
        self.nativeAd = [[LYNativeAd alloc] initWithSlotId:nativeId];
        self.nativeAd.delegate = self;
    }
    [self.nativeAd loadAdWithCount:3];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.adDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYNativeAdDataObject *dataObject = self.adDataArray[indexPath.row];
    if (dataObject.creativeType == LYNativeAdCreativeType_GDT_isVideoAd
            || dataObject.creativeType == LYNativeAdCreativeType_CSJ_VideoImage
            || dataObject.creativeType == LYNativeAdCreativeType_CSJ_VideoPortrait
            || dataObject.creativeType == LYNativeAdCreativeType_CSJ_SquareVideo
            || dataObject.creativeType == LYNativeAdCreativeType_KS_AdMaterialTypeVideo
            || dataObject.creativeType == LYNativeAdCreativeType_KLN_HorVideo
            || dataObject.creativeType == LYNativeAdCreativeType_BD_VIDEO
            || dataObject.creativeType == LYNativeAdCreativeType_GRO_LandscapeVideo
            || dataObject.creativeType == LYNativeAdCreativeType_GRO_PortraitVideo
            || dataObject.creativeType == LYNativeAdCreativeType_ADX_VIDEO
        ) {
        return [LYDNativeAdVideoCell cellHeightWithNativeAdDataObject:dataObject];
    } else {
        return [LYDNativeAdImageCell cellHeightWithNativeAdDataObject:dataObject];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYNativeAdDataObject *dataObject = self.adDataArray[indexPath.row];
    if (dataObject.creativeType == LYNativeAdCreativeType_GDT_isVideoAd
        || dataObject.creativeType == LYNativeAdCreativeType_CSJ_VideoImage
        || dataObject.creativeType == LYNativeAdCreativeType_CSJ_VideoPortrait
        || dataObject.creativeType == LYNativeAdCreativeType_CSJ_SquareVideo
        || dataObject.creativeType == LYNativeAdCreativeType_KS_AdMaterialTypeVideo
        || dataObject.creativeType == LYNativeAdCreativeType_KLN_HorVideo
        || dataObject.creativeType == LYNativeAdCreativeType_BD_VIDEO
        || dataObject.creativeType == LYNativeAdCreativeType_GRO_LandscapeVideo
        || dataObject.creativeType == LYNativeAdCreativeType_GRO_PortraitVideo
        || dataObject.creativeType == LYNativeAdCreativeType_ADX_VIDEO
        ) {
        LYDNativeAdVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LYDNativeAdVideoCell"];
        [cell setupWithNativeAdDataObject:dataObject delegate:self vc:self];
        return cell;
    } else {
        LYDNativeAdImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LYDNativeAdImageCell"];
        [cell setupWithNativeAdDataObject:dataObject delegate:self vc:self];
        return cell;
    }
}

#pragma mark - LYNativeAdDelegate

- (void)ly_nativeAdDidLoad:(NSArray<LYNativeAdDataObject *> * _Nullable)nativeAdDataObjects error:(NSError * _Nullable)error {
    if (error) {
        NSString *text = [NSString stringWithFormat:@"native|%@|%@", NSStringFromSelector(_cmd), [error debugDescription]];
        [[KSBulletScreenManager sharedInstance] showWithText:text];
    } else {
        NSString * unionType = @"";
        if (nativeAdDataObjects.count) {
            for (int i = 0; i < nativeAdDataObjects.count; i++) {
                LYNativeAdDataObject * nativeAdDataObject = nativeAdDataObjects[i];
                unionType = [unionType stringByAppendingString:[LYDUnionTypeTool unionName4unionType:nativeAdDataObject.unionType]];
                if (i + 1 < nativeAdDataObjects.count) {
                    unionType = [unionType stringByAppendingString:@"|"];
                }
            }
        }
        NSString *text = [NSString stringWithFormat:@"native|%@|%@", NSStringFromSelector(_cmd), unionType];
        [[KSBulletScreenManager sharedInstance] showWithText:text];
        if (nativeAdDataObjects.count > 0) {
            [self.adDataArray addObjectsFromArray:nativeAdDataObjects];
            [self.tableView reloadData];
        }
    }
}

#pragma mark - LYNativeAdViewDelegate

- (void)ly_nativeAdViewDidExpose:(LYNativeAdView *)nativeAdView {
    NSString *text = [NSString stringWithFormat:@"native|%@|%ld", NSStringFromSelector(_cmd), [nativeAdView eCPM]];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_nativeAdViewDidClick:(LYNativeAdView *)nativeAdView {
    NSString *text = [NSString stringWithFormat:@"native|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_nativeAdViewMediaDidPlayFinish:(LYNativeAdView *)nativeAdView {
    NSString *text = [NSString stringWithFormat:@"native|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_nativeAdViewDidCloseOtherController:(LYNativeAdView *)nativeAdView {
    NSString *text = [NSString stringWithFormat:@"native|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

- (void)ly_nativeAdViewDislike:(LYNativeAdView *)nativeAdView {
    NSString *text = [NSString stringWithFormat:@"native|%@", NSStringFromSelector(_cmd)];
    [[KSBulletScreenManager sharedInstance] showWithText:text];
}

@end
