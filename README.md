# 广告 iOS SDK 接入文档

## SDK项目部署

### 开发环境

- **开发工具**：推荐Xcode 12及以上版本

- **部署目标**：iOS 9.0及以上

- **SDK版本**：官网最新版本

### pod方式接入

```ruby
# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
# 添加LYSpecs私库
source 'https://gitee.com/happytour/LYSpecs.git'

platform :ios, '9.0'

workspace 'LYAdSDKDemo'
project 'LYAdSDKDemo'

target 'LYAdSDKDemo' do
  pod 'Ads-CN', '3.9.0.3'
  pod 'GDTMobSDK', '4.13.10'
  pod 'SigmobAd-iOS', '3.2.4'
  pod 'BaiduMobAdSDK', '4.81'
  # KSAdSDKFull、QySdk、JADYun，没有提交到官方库，需要引入LYSpecs私库拉取
  pod 'fork-KSAdSDKFull', '3.3.23'
  pod 'fork-QySdk', '1.3.2'
  pod 'fork-JADYun' , '1.2.4'
  pod 'WechatOpenSDK', '1.8.7.1'

  pod 'LYAdSDK**', '2.3.0'
  pod 'LYAdSDKAdapterForCSJ', '2.3.0'
  pod 'LYAdSDKAdapterForGDT', '2.3.0'
  pod 'LYAdSDKAdapterForKS', '2.3.0'
  pod 'LYAdSDKAdapterForSIG', '2.3.0'
  pod 'LYAdSDKAdapterForIQY', '2.3.0'
  pod 'LYAdSDKAdapterForBD', '2.3.0'
  pod 'LYAdSDKAdapterForJD', '2.3.0'
  project 'LYAdSDKDemo'
end
```

### 手动接入

请参考对应平台接入文档依次接入，最后将LYAdSDK.framework及对应Adapter的framework拖放到项目。  

点击主工程 -> Build Settings -> 搜索Other Linker Flags -> 在列表中找到Other Linker Flags -> 添加参数-ObjC

### info.plist配置

#### http限制

在info.plist中添加 App Transport Security Settings 设定，由于苹果默认限制HTTP请求，需手动配置才可正常访问HTTP请求，SDK的API均已使用HTTPS但部分媒体资源需要使用HTTP TIPS：可以右击info.plist文件，选择Open As -> Source Code，然后将下列代码粘贴进去

```javascript
<key>NSAppTransportSecurity</key>
    <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
    </dict>
```

#### 关于 iOS 14 AppTrackingTransparency

在 iOS 14 设备上，建议您在应用启动时调用 apple 提供的 AppTrackingTransparency 方案，获取用户的 IDFA 授权，以便提供更精准的广告投放和收入优化

```javascript
<key>NSUserTrackingUsageDescription</key>
<string>需要获取您设备的广告标识符，以为您提供更好的广告体验</string>
```

权限请求窗口调用方法：`requestTrackingAuthorization(completionHandler:)`

## 接入代码

请向相关人员申请测试appId和slotId

### SDK版本号

```objectivec
// 例：2.0.0
NSLog(@"sdkVersion: %@", [LYAdSDKConfig sdkVersion]);
```

### 初始化

```objectivec
// userId在任何能获取到的时候都可以设置，最后一次设置会覆盖之前
[LYAdSDKConfig setUserId:@"媒体用户唯一ID，可以是脱敏后的需保证唯一"];
[LYAdSDKConfig initAppId:@"你的APPID"];
```

### 通知广告 LYNoticeAd

```objectivec
// LYNoticeAd代理
@protocol LYNoticeAdDelegate <NSObject>
// 加载成功回调
- (void)ly_noticeAdDidLoad:(LYNoticeAd *)noticeAd;
// 加载失败回调
- (void)ly_noticeAdDidFailToLoad:(LYNoticeAd *)noticeAd error:(NSError *)error;
// 曝光回调
- (void)ly_noticeAdDidExpose:(LYNoticeAd *)noticeAd;
// 点击回调
- (void)ly_noticeAdDidClick:(LYNoticeAd *)noticeAd;
// 关闭回调
- (void)ly_noticeAdDidClose:(LYNoticeAd *)noticeAd;
@end
```

```objectivec
// notice load
self.noticeAd = [[LYNoticeAd alloc] initWithSlotId:@"你的广告位ID"];
self.noticeAd.delegate = self;
[self.noticeAd loadAd];
```

### 开屏广告 LYSplashAd

```objectivec
// LYSplashAd代理
@protocol LYSplashAdDelegate <NSObject>
@optional
// 加载成功回调，在这之后调用show逻辑
- (void)ly_splashAdDidLoad:(LYSplashAd *)splashAd;
// 加载失败
- (void)ly_splashAdDidFailToLoad:(LYSplashAd *)splashAd error:(NSError *)error;
// 曝光回调
- (void)ly_splashAdDidExpose:(LYSplashAd *)splashAd;
// 点击回调
- (void)ly_splashAdDidClick:(LYSplashAd *)splashAd;
// 即将关闭回调
- (void)ly_splashAdWillClose:(LYSplashAd *)splashAd;
// 关闭回调
- (void)ly_splashAdDidClose:(LYSplashAd *)splashAd;
// 开屏倒计时回调
- (void)ly_splashAdLifeTime:(LYSplashAd *)splashAd time:(NSUInteger)time;
// 详情页关闭回调
- (void)ly_splashAdDidCloseOtherController:(LYSplashAd *)splashAd;

@end
```

```objectivec
// splash load
CGRect frame = [UIScreen mainScreen].bounds;
CGRect plashFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
if (...包含sigmob或者京东预算...) {
    // 其中self.rootController需要与showAdInWindow时window.rootViewController一致
    self.splashAd = [[LYSplashAd alloc] initWithFrame:splashFrame slotId:ly_splash_id viewController:self.rootController];
} else {
    self.splashAd = [[LYSplashAd alloc] initWithFrame:splashFrame slotId:@"你的广告位ID"];
}
self.splashAd.delegate = self;
[self.splashAd loadAd];
...
// splash show
// 在收到ly_splashAdDidLoad回调后调用show逻辑
if (...需要自定义底部logo...) {
    UILabel *bottomView = [[UILabel alloc] initWithFrame:bottomFrame];
    [bottomView setText:@"这是一个测试LOGO"];
    bottomView.backgroundColor = [UIColor redColor];
    [self.splashAd showAdInWindow:keyWindow withBottomView:bottomView];
} else {
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
    [self.splashAd showAdInWindow:keyWindow];
}
```

### 信息流广告

#### 自渲染 LYNativeAd

```objectivec
// LYNativeAd代理
@protocol LYNativeAdDelegate <NSObject>
// 加载成功回调
- (void)ly_nativeAdDidLoad:(NSArray<LYNativeAdDataObject *> * _Nullable)nativeAdDataObjects error:(NSError * _Nullable)error;

@end
// LYNativeAdView代理
@protocol LYNativeAdViewDelegate <NSObject>
@optional
// 曝光回调
- (void)ly_nativeAdViewDidExpose:(LYNativeAdView *)nativeAdView;
// 点击回调
- (void)ly_nativeAdViewDidClick:(LYNativeAdView *)nativeAdView;
// 广告详情页关闭回调
- (void)ly_nativeAdViewDidCloseOtherController:(LYNativeAdView *)nativeAdView;
// 如果是视频广告，播放完成回调
- (void)ly_nativeAdViewMediaDidPlayFinish:(LYNativeAdView *)nativeAdView;
// 带关闭按钮的广告，用户点击后的回调
- (void)ly_nativeAdViewDislike:(LYNativeAdView *)nativeAdView;
@end
```

```objectivec
// native load
self.nativeAd = [[LYNativeAd alloc] initWithSlotId:@"你的广告位ID"];
self.nativeAd.delegate = self;
[self.nativeAd loadAdWithCount:3];// 支持1-3
...
// 渲染逻辑
self.adView = [[LYNativeAdView alloc] init];
self.adView.delegate = delegate; // adView 广告回调
self.adView.viewController = vc; // 跳转 VC
//重要，先调用refreshData，dataObject是LYNativeAdDataObject对象
[self.adView refreshData:dataObject];
...
省略 具体渲染逻辑，参见demo
...
//重要，最后调用registerDataObjectWithClickableViews注册可点击view
[self.adView registerDataObjectWithClickableViews:@[...]];
```

```objectivec
// LYNativeAdDataObject
typedef NS_ENUM(NSInteger, LYNativeAdCreativeType) {
    LYNativeAdCreativeType_ADX_NONE = (1 << 24) | 0,
    LYNativeAdCreativeType_ADX_TXT = (1 << 24) | 1,//TXT 纯文字
    LYNativeAdCreativeType_ADX_IMG = (1 << 24) | 2,//IMG 纯图片
    LYNativeAdCreativeType_ADX_HYBRID = (1 << 24) | 3,//HYBRID 图文混合
    LYNativeAdCreativeType_ADX_VIDEO = (1 << 24) | 4,//VIDEO 视频广告

    LYNativeAdCreativeType_GDT_isVideoAd = (2 << 24) | 2,//isVideoAd
    LYNativeAdCreativeType_GDT_isThreeImgsAd = (2 << 24) | 3,//isThreeImgsAd

    LYNativeAdCreativeType_CSJ_SmallImage = (3 << 24) | 2,
    LYNativeAdCreativeType_CSJ_LargeImage = (3 << 24) | 3,
    LYNativeAdCreativeType_CSJ_GroupImage = (3 << 24) | 4,
    LYNativeAdCreativeType_CSJ_VideoImage = (3 << 24) | 5,// video ad || rewarded video ad horizontal screen
    LYNativeAdCreativeType_CSJ_VideoPortrait = (3 << 24) | 15,// rewarded video ad vertical screen
    LYNativeAdCreativeType_CSJ_ImagePortrait = (3 << 24) | 16,
    LYNativeAdCreativeType_CSJ_SquareImage = (3 << 24) | 33,//SquareImage Currently it exists only in the oversea now. V3200 add
    LYNativeAdCreativeType_CSJ_SquareVideo = (3 << 24) | 50,//SquareVideo Currently it exists only in the oversea now. V3200 add
};

@interface LYNativeAdDataObject : NSObject
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *desc;
@property (nonatomic, copy, readonly) NSString *imageUrl;
@property (nonatomic, readonly) NSInteger imageWidth;
@property (nonatomic, readonly) NSInteger imageHeight;
@property (nonatomic, copy, readonly) NSString *iconUrl;
@property (nonatomic, copy, readonly) NSArray *imageUrls;
// 创意类型，返回LYNativeAdCreativeType中的值
@property (nonatomic, readonly) LYNativeAdCreativeType creativeType;
@property (nonatomic, strong) LYVideoConfig *videoConfig;
@end
```

#### 模板渲染 LYNativeExpressAd

```objectivec
// LYNativeExpressAd代理
@protocol LYNativeExpressAdDelegate <NSObject>
// 广告加载成功回调
- (void)ly_nativeExpressAdDidLoad:(NSArray<LYNativeExpressAdRelatedView *> * _Nullable)nativeExpressAdRelatedViews error:(NSError * _Nullable)error;
@end
// LYNativeExpressAdRelatedView代理
@protocol LYNativeExpressAdRelatedViewDelegate <NSObject>
@optional
// 渲染成功回调
- (void)ly_nativeExpressAdRelatedViewDidRenderSuccess:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView;
// 渲染失败回调
- (void)ly_nativeExpressAdRelatedViewDidRenderFail:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView;
// 曝光回调
- (void)ly_nativeExpressAdRelatedViewDidExpose:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView;
// 点击回调
- (void)ly_nativeExpressAdRelatedViewDidClick:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView;
// 广告详情页关闭回调
- (void)ly_nativeExpressAdRelatedViewDidCloseOtherController:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView;
// 带关闭按钮的广告，用户点击关闭时回调
- (void)ly_nativeExpressAdRelatedViewDislike:(LYNativeExpressAdRelatedView *)nativeExpressAdRelatedView;
@end
```

```objectivec
// native express load
self.nativeExpressAd = [[LYNativeExpressAd alloc] initWithSlotId:@"你的广告位ID" adSize:CGSizeMake(width, 0)];
self.nativeExpressAd.delegate = self;
[self.nativeExpressAd loadAdWithCount:3]; // 支持，1-3
...
// 广告加载成功后，调用render
LYNativeExpressAdRelatedView *relatedView = (LYNativeExpressAdRelatedView *)obj;
relatedView.delegate = self;
relatedView.viewController = self;
[relatedView render];
...
// 渲染成功后，通过getAdView拿到广告View，添加到界面上
UIView *view = [[self.expressAdRelatedViews objectAtIndex:indexPath.row] getAdView];
```

### 激励视频广告 LYRewardVideoAd

```objectivec
@protocol LYRewardVideoAdDelegate <NSObject>
@optional
// 加载成功回调
- (void)ly_rewardVideoAdDidLoad:(LYRewardVideoAd *)rewardVideoAd;
// 加载失败回调
- (void)ly_rewardVideoAdDidFailToLoad:(LYRewardVideoAd *)rewardVideoAd error:(NSError *)error;
// 激励视频缓存成功
- (void)ly_rewardVideoAdDidCache:(LYRewardVideoAd *)rewardVideoAd;
// 曝光回调
- (void)ly_rewardVideoAdDidExpose:(LYRewardVideoAd *)rewardVideoAd;
// 点击回调
- (void)ly_rewardVideoAdDidClick:(LYRewardVideoAd *)rewardVideoAd;
// 关闭回调
- (void)ly_rewardVideoAdDidClose:(LYRewardVideoAd *)rewardVideoAd;
// 播放完成回调
- (void)ly_rewardVideoAdDidPlayFinish:(LYRewardVideoAd *)rewardVideoAd;
// 奖励回调
- (void)ly_rewardVideoAdDidRewardEffective:(LYRewardVideoAd *)rewardVideoAd trackUid:(NSString *) trackUid;
@end
```

```objectivec
// 激励视频 load
// 重要，如需服务器回调则需保证setUserId在调用激励视频之前设置
// [LYAdSDKConfig setUserId:@"媒体用户唯一ID，可以是脱敏后的需保证唯一"];
if (...需要服务验证，且有拓展参数需要原样返回...) {
    //非必要，需服务器验证时extra原样回调到媒体服务器
    self.rewardedAd = [[LYRewardVideoAd alloc] initWithSlotId:@"你的广告位ID" extra:@"非必要拓展参数"];
} else {
    self.rewardedAd = [[LYRewardVideoAd alloc] initWithSlotId:@"你的广告位ID"];
}
self.rewardedAd.delegate = self;
[self.rewardedAd loadAd];
...
// 激励视频 show，建议在收到ly_rewardVideoAdDidCache回调后调用
[self.rewardedAd showAdFromRootViewController:self];
```

### 插屏广告 LYInterstitialAd

```objectivec
//LYInterstitialAd代理
@protocol LYInterstitialAdDelegate <NSObject>
@optional
// 加载成功回调
- (void)ly_interstitialAdDidLoad:(LYInterstitialAd *)interstitialAd;
// 加载失败回调
- (void)ly_interstitialAdDidFailToLoad:(LYInterstitialAd *)interstitialAd error:(NSError *)error;
// 曝光回调
- (void)ly_interstitialAdDidExpose:(LYInterstitialAd *)interstitialAd;
// 点击回调
- (void)ly_interstitialAdDidClick:(LYInterstitialAd *)interstitialAd;
// 关闭回调
- (void)ly_interstitialAdDidClose:(LYInterstitialAd *)interstitialAd;
@end
```

```objectivec
// interstitial load
CGSize adSize = CGSizeMake(300, 450);
self.interstitial = [[LYInterstitialAd alloc] initWithSlotId:@"你的广告位ID" adSize:adSize];
self.interstitial.delegate = self;
[self.interstitial loadAd];
...
// interstitial show，在收到加载成功回调之后调用show方法
[self.interstitial showAdFromRootViewController:self];
```

### Banner广告 LYBannerAdView

```objectivec
// LYBannerAdView代理
@protocol LYBannerAdViewDelegate <NSObject>
@optional
// 加载成功回调
- (void)ly_bannerAdViewDidLoad:(LYBannerAdView *)bannerAd;
// 加载失败回调
- (void)ly_bannerAdViewDidFailToLoad:(LYBannerAdView *)bannerAd error:(NSError *)error;
// 曝光回调
- (void)ly_bannerAdViewDidExpose:(LYBannerAdView *)bannerAd;
// 点击回调
- (void)ly_bannerAdViewDidClick:(LYBannerAdView *)bannerAd;
// 关闭回调
- (void)ly_bannerAdViewDidClose:(LYBannerAdView *)bannerAd;
@end
```

```objectivec
// banner load
self.bannerView = [[LYBannerAdView alloc] initWithFrame:frame slotId:@"你的广告位ID" viewController:self];
self.bannerView.delegate = self;
[self.bannerView loadAd];
...
// 在ly_bannerAdViewDidLoad回调之后，将bannerView添加到界面上
[self.view addSubview:self.bannerView];
```

### 全屏视频广告 LYFullScreenVideoAd

```objectivec
// LYFullScreenVideoAd代理
@protocol LYFullScreenVideoAdDelegate <NSObject>
@optional
// 加载成功回调
- (void)ly_fullScreenVideoAdDidLoad:(LYFullScreenVideoAd *)fullScreenVideoAd;
// 加载失败回调
- (void)ly_fullScreenVideoAdDidFailToLoad:(LYFullScreenVideoAd *)fullScreenVideoAd error:(NSError *)error;
// 视频缓存成功
- (void)ly_fullScreenVideoAdDidCache:(LYFullScreenVideoAd *)fullScreenVideoAd;
// 曝光回调
- (void)ly_fullScreenVideoAdDidExpose:(LYFullScreenVideoAd *)fullScreenVideoAd;
// 点击回调
- (void)ly_fullScreenVideoAdDidClick:(LYFullScreenVideoAd *)fullScreenVideoAd;
// 关闭回调
- (void)ly_fullScreenVideoAdDidClose:(LYFullScreenVideoAd *)fullScreenVideoAd;
// 播放完成回调
- (void)ly_fullScreenVideoAdDidPlayFinish:(LYFullScreenVideoAd *)fullScreenVideoAd;
// 跳过回调
- (void)ly_fullScreenVideoAdDidClickSkip:(LYFullScreenVideoAd *)fullScreenVideoAd;
@end
```

```objectivec
// 全屏视频 load
self.fullScreenVideoAd = [[LYFullScreenVideoAd alloc] initWithSlotId:@"你的广告位ID"];
self.fullScreenVideoAd.delegate = self;
...
[self.fullScreenVideoAd loadAd];
...
// 全屏视频 show，建议在收到ly_fullScreenVideoAdDidCache回调后调用
[self.fullScreenVideoAd showAdFromRootViewController:self];
```

### Draw视频广告 LYDrawVideoAd

```objectivec
// LYDrawVideoAd代理
@protocol LYDrawVideoAdDelegate <NSObject>
// 广告加载成功回调
- (void)ly_drawVideoAdDidLoad:(NSArray<LYDrawVideoAdRelatedView *> * _Nullable) drawVideoAdRelatedViews error:(NSError * _Nullable) error;
@end
// LYDrawVideoAdRelatedView代理
@protocol LYDrawVideoAdRelatedViewDelegate <NSObject>
@optional
// 曝光回调
- (void)ly_drawVideoAdRelatedViewDidExpose:(LYDrawVideoAdRelatedView *)drawVideoAdRelatedView;
// 点击回调
- (void)ly_drawVideoAdRelatedViewDidClick:(LYDrawVideoAdRelatedView *)drawVideoAdRelatedView;
// 广告详情页关闭回调
- (void)ly_drawVideoAdRelatedViewDidCloseOtherController:(LYDrawVideoAdRelatedView *)drawVideoAdRelatedView;
// 视频播放完成回调
- (void)ly_drawVideoAdRelatedViewDidPlayFinish:(LYDrawVideoAdRelatedView *)drawVideoAdRelatedView;
@end
```

```objectivec
// draw load
self.drawVideoAd = [[LYDrawVideoAd alloc] initWithSlotId:@"你的广告位ID" adSize:[[UIScreen mainScreen] bounds].size];
self.drawVideoAd.delegate = self;
[self.drawVideoAd loadAdWithCount:3];
...
// 广告加载成功后，设置delegate及viewController
LYDrawVideoAdRelatedView *relatedView = (LYDrawVideoAdRelatedView *)obj;
relatedView.delegate = self;
relatedView.viewController = self;
...
// 调用registerContainer将广告展示到界面
[self.relatedView registerContainer:self.contentView];
...
// cell复用时调用unregisterView
[self.relatedView unregisterView];
```

### 视频内容 LYContentPage

```objectivec
// LYContentPage代理
@protocol LYContentPageDelegate <NSObject>
@optional
// 加载成功回调
- (void)ly_contentPageDidLoad:(LYContentPage *)entryElement;
// 加载失败回调
- (void)ly_contentPageDidFailToLoad:(LYContentPage *)entryElement error:(NSError *)error;
@end
// 内容页相关回调
@protocol LYContentPageContentDelegate <NSObject>
@optional
- (void)ly_contentPageContentDidFullDisplay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo;
- (void)ly_contentPageContentDidEndDisplay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo;
- (void)ly_contentPageContentDidPause:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo;
- (void)ly_contentPageContentDidResume:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo;
@end
// 内容页视频相关回调
@protocol LYContentPageVideoDelegate <NSObject>
@optional
- (void)ly_contentPageVideoDidStartPlay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo;
- (void)ly_contentPageVideoDidPause:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo;
- (void)ly_contentPageVideoDidResume:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo;
- (void)ly_contentPageVideoDidEndPlay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo;
- (void)ly_contentPageVideoDidFailToPlay:(LYContentPage *)entryElement contentInfo:(LYContentInfo *) contentInfo error:(NSError *)error;
@end
```

```objectivec
// content load
self.contentPage = [[LYContentPage alloc] initWithSlotId:@"你的广告"];
self.contentPage.delegate = self;
self.contentPage.contentDelegate = self;
self.contentPage.videoDelegate = self;
// addChildViewController、addSubview后开始加载内容
UIViewController * vc = self.contentPage.viewController;
[self addChildViewController:vc];
vc.view.frame = frame;
[self.view addSubview:vc.view]; 
```

```objectivec
// LYContentInfo
typedef NS_ENUM(NSUInteger, LYContentType) {
    LYContentTypeUnknown,         //未知，正常不会出现
    LYContentTypeNormal,          //普通信息流
    LYContentTypeAd,              //SDK内部广告
};
@interface LYContentInfo : NSObject
//内容标识
@property (nonatomic, copy, readonly) NSString *contentId;
//内容类型
@property (nonatomic, readonly) LYContentType contentType;
//视频时长. 毫秒
@property (nonatomic, readonly) NSTimeInterval videoDuration;
@end
```

### 入口组件 LYEntryElement

参考demo

## 注意

如果要接入微信小程序唤起广告，一定要注意在AppDelegate中加入这段代码，不然会出现调起微信之后又回到APP中，无法真正调起小程序。

```objectivec
- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    if (...媒体自己处理微信回调...) {
        return [WXApi handleOpenUniversalLink:userActivity delegate:self];
    } else {
        // 由SDK处理
        return [LYAdSDKConfig handleOpenUniversalLink:userActivity];
    }
}
```
