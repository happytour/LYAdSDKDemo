//
//  LYNativeViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/11.
//

#import "LYNativeViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"
#import "LYNativeAdImageCell.h"
#import "LYNativeAdVideoCell.h"

@interface LYNativeViewController ()<LYNativeAdDelegate, LYNativeAdViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) LYNativeAd * nativeAd;
@property (nonatomic, strong) NSMutableArray<LYNativeAdDataObject *> *adDataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LYNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"Native", nil)];

    self.textField.text = ly_native_id;
    [self appendLogText:self.title];
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat tableViewY = self.y += 10;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.y, CGRectGetWidth(self.view.frame) - 20, screenHeight - tableViewY - 10) style:UITableViewStylePlain];
    [self.tableView registerClass:[LYNativeAdImageCell class] forCellReuseIdentifier:@"LYNativeAdImageCell"];
    [self.tableView registerClass:[LYNativeAdVideoCell class] forCellReuseIdentifier:@"LYNativeAdVideoCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.adDataArray = [NSMutableArray new];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load NativeAd"];
    self.textField.enabled = NO;
    if (!self.nativeAd) {
        self.nativeAd = [[LYNativeAd alloc] initWithSlotId:self.textField.text];
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
        ) {
        return [LYNativeAdVideoCell cellHeightWithNativeAdDataObject:dataObject];
    } else {
        return [LYNativeAdImageCell cellHeightWithNativeAdDataObject:dataObject];
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
        ) {
        LYNativeAdVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LYNativeAdVideoCell"];
        [cell setupWithNativeAdDataObject:dataObject delegate:self vc:self];
        return cell;
    } else {
        LYNativeAdImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LYNativeAdImageCell"];
        [cell setupWithNativeAdDataObject:dataObject delegate:self vc:self];
        return cell;
    }
}

#pragma mark - LYNativeAdDelegate

- (void)ly_nativeAdDidLoad:(NSArray<LYNativeAdDataObject *> * _Nullable)nativeAdDataObjects error:(NSError * _Nullable)error {
    if (error) {
        [self appendLogText:[NSString stringWithFormat:@"ly_nativeAdDidLoad, error:%@,%@", error.domain, error.localizedDescription]];
    } else {
        [self appendLogText:[NSString stringWithFormat:@"ly_nativeAdDidLoad, unionType: %@", [LYUnionTypeTool unionName4unionType:self.nativeAd.unionType]]];
        if (nativeAdDataObjects.count > 0) {
            [self.adDataArray addObjectsFromArray:nativeAdDataObjects];
            [self.tableView reloadData];
        }
    }
}

#pragma mark - LYNativeAdViewDelegate

- (void)ly_nativeAdViewDidExpose:(LYNativeAdView *)nativeAdView {
    [self appendLogText:[NSString stringWithFormat:@"ly_nativeAdViewDidExpose, eCPM: %ld", [self.nativeAd eCPM]]];
}

- (void)ly_nativeAdViewDidClick:(LYNativeAdView *)nativeAdView {
    [self appendLogText:@"ly_nativeAdViewDidClick"];
}

- (void)ly_nativeAdViewMediaDidPlayFinish:(LYNativeAdView *)nativeAdView {
    [self appendLogText:@"ly_nativeAdViewMediaDidPlayFinish"];
}

- (void)ly_nativeAdViewDidCloseOtherController:(LYNativeAdView *)nativeAdView {
    [self appendLogText:@"ly_nativeAdViewDidCloseOtherController"];
}

- (void)ly_nativeAdViewDislike:(LYNativeAdView *)nativeAdView {
    [self appendLogText:@"ly_nativeAdViewDislike"];
}

@end
