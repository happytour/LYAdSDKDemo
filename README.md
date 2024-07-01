# 广告 iOS SDK 接入文档

## SDK项目部署

### 开发环境

- **开发工具**：推荐Xcode 12及以上版本

- **部署目标**：iOS 11.0及以上

- **SDK版本**：官网最新版本

### pod方式接入

```ruby
# Uncomment the next line to define a global platform for your project
# CocoaPods官方库
#source 'https://github.com/CocoaPods/Specs.git'
# 清华大学镜像库，如果上面库无法加载请使用下面镜像
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
# 添加LYSpecs私库
source 'https://gitee.com/happytour/LYSpecs.git'

platform :ios, '11.0'

workspace 'LYAdSDKDemo'
project 'LYAdSDKDemo'

target 'LYAdSDKDemo' do
#  pod 'Ads-CN-Beta', '6.1.0.2' #不与Ads-Fusion-CN-Beta同时存在
  pod 'Ads-Fusion-CN-Beta','6.1.2.8', :subspecs => ['BUAdSDK', 'CSJMediation'] #不与Ads-CN-Beta同时存在
  pod 'GDTMobSDK', '4.14.80'
  pod 'BaiduMobAdSDK', '5.35'
  pod 'KSAdSDK', '3.3.65'
  # KSAdSDKFull、JADYun，没有提交到官方库，需要引入LYSpecs私库拉取
#  pod 'fork-KSAdSDKFull', '3.3.32'
  pod 'fork-JADYun' , '2.5.12'
  
  pod 'LYAdSDK', '2.7.0'
  #pod 'LYAdSDKAdapterForCSJ', '2.6.5' # 穿山甲支持，当接入穿山甲SDK跑穿山甲或者接入穿山甲融合SDK只跑穿山甲时使用，不与LYAdSDKAdapterForGromore同时存在。
  pod 'LYAdSDKAdapterForGDT', '2.6.4' # 广点通支持
  pod 'LYAdSDKAdapterForKS', '2.6.4' # 快手AD支持
#  pod 'LYAdSDKAdapterForKSContent', '2.5.0' # 快手内容支持
  pod 'LYAdSDKAdapterForBD', '2.6.3' # 百度支持
  pod 'LYAdSDKAdapterForJD', '2.6.5' # 京东支持
  pod 'LYAdSDKAdapterForGromore', '2.6.3' # 穿山甲融合支持，当接入穿山甲融合SDK时使用，不与LYAdSDKAdapterForCSJ同时存在。
  
  # 以下库仅在Dmeo中使用
  pod 'Masonry', '~> 1.1.0'
  pod 'MMKV', '~> 1.2.15'
  pod 'SVProgressHUD', '~> 2.2.5'
  project 'LYAdSDKDemo'
end

```

### 手动接入

请参考对应平台接入文档依次接入，最后将LYAdSDK.xcframework及对应Adapter的framework拖放到项目。  

点击主工程 -> Build Settings -> 搜索Other Linker Flags -> 在列表中找到Other Linker Flags -> 添加参数-ObjC

## info.plist配置

### http限制

在info.plist中添加 App Transport Security Settings 设定，由于苹果默认限制HTTP请求，需手动配置才可正常访问HTTP请求，SDK的API均已使用HTTPS但部分媒体资源需要使用HTTP TIPS：可以右击info.plist文件，选择Open As -> Source Code，然后将下列代码粘贴进去

```javascript
<key>NSAppTransportSecurity</key>
    <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
    </dict>
```
### iOS17隐私策略的适配说明
* 在2.6.5.1及以上的版本，我们已新增 PrivacyInfo.xcprivacy 文件，位于静态库产物的LYAdSDK.xcframework中。
* 您可以用cocoapods集成，手动集成，无论使用哪种方式，都可以在xcode项目的LYAdSDK.xcframework->ios-arm64->LYAdSDK.framework->PrivacyInfo.xcprivacy找到，请注意将PrivacyInfo.xcprivacy 拷贝进您的代码工程里。
* 如果您的App本身包含PrivacyInfo.xcprivacy文件，请将LYAdSDK的PrivacyInfo.xcprivacy
的PrivacyInfo.xcprivacy中的条款补全到自身的PrivacyInfo.xcprivacy中，具体补全方式如下：
  * 使用source code方式添加：
    * Xcode 中使用 Source Code方式打开 app 项目下的 PrivacyInfo.xcprivacy。复制LYAdSDK的PrivacyInfo.xcprivacy
的 PrivacyInfo.xcprivacy中的条目，注意不要重复添加或错行。
  * 使用 Property List 的方式添加：
    * 在 Xcode 中双击打开 PrivacyInfo.xcprivacy 文件，在其中点击+，Xcode会提示可选的条款和可设置项，按照需求进行增补即可。
* 如果您的项目同时集成了多个包含PrivacyInfo.xcprivacy的SDK，建议您将所有SDK的条款补充到您自身App的PrivacyInfo.xcprivacy中。在补充时，对于同一个API的声明和原因解释，无需重复添加。

LYAdSDK的PrivacyInfo.xcprivacy
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>NSPrivacyCollectedDataTypes</key>
	<array>
		<dict>
			<key>NSPrivacyCollectedDataType</key>
			<string>NSPrivacyCollectedDataTypeDeviceID</string>
			<key>NSPrivacyCollectedDataTypeLinked</key>
			<false/>
			<key>NSPrivacyCollectedDataTypeTracking</key>
			<false/>
			<key>NSPrivacyCollectedDataTypePurposes</key>
			<array>
				<string>NSPrivacyCollectedDataTypePurposeThirdPartyAdvertising</string>
			</array>
		</dict>
	</array>
	<key>NSPrivacyAccessedAPITypes</key>
	<array>
		<dict>
			<key>NSPrivacyAccessedAPITypeReasons</key>
			<array>
				<string>3B52.1</string>
			</array>
			<key>NSPrivacyAccessedAPIType</key>
			<string>NSPrivacyAccessedAPICategoryFileTimestamp</string>
		</dict>
		<dict>
			<key>NSPrivacyAccessedAPITypeReasons</key>
			<array>
				<string>35F9.1</string>
			</array>
			<key>NSPrivacyAccessedAPIType</key>
			<string>NSPrivacyAccessedAPICategorySystemBootTime</string>
		</dict>
		<dict>
			<key>NSPrivacyAccessedAPITypeReasons</key>
			<array>
				<string>E174.1</string>
			</array>
			<key>NSPrivacyAccessedAPIType</key>
			<string>NSPrivacyAccessedAPICategoryDiskSpace</string>
		</dict>
		<dict>
			<key>NSPrivacyAccessedAPITypeReasons</key>
			<array>
				<string>CA92.1</string>
			</array>
			<key>NSPrivacyAccessedAPIType</key>
			<string>NSPrivacyAccessedAPICategoryUserDefaults</string>
		</dict>
	</array>
	<key>NSPrivacyTrackingDomains</key>
	<array/>
	<key>NSPrivacyTracking</key>
	<false/>
</dict>
</plist>

```

### 关于 iOS 14 AppTrackingTransparency

在 iOS 14 设备上，建议您在应用启动时调用 apple 提供的 AppTrackingTransparency 方案，获取用户的 IDFA 授权，以便提供更精准的广告投放和收入优化

```javascript
<key>NSUserTrackingUsageDescription</key>
<string>需要获取您设备的广告标识符，以为您提供更好的广告体验</string>
```

权限请求窗口调用方法：`requestTrackingAuthorization(completionHandler:)`

## 初始化

请向相关人员申请测试appId和slotId
```objectivec
// userId在任何能获取到的时候都可以设置，最后一次设置会覆盖之前
[LYAdSDKConfig setUserId:@"媒体用户唯一ID，可以是脱敏后的需保证唯一"];
if (...需要隐私政策配置...) {
    LYAdSDKPrivacyConfig * privacy = [[LYAdSDKPrivacyConfig alloc] init];
    privacy.canUseIDFA = NO;// 根据实际情况填写
    privacy.canUseLocation = NO;// 根据实际情况填写
    // 当canUseIDFA为NO时，customIDFA生效，可以为nil
    privacy.customIDFA = @"00000000-0000-0000-0000-000000000000";// 根据实际情况填写
    LYAdSDKLocation * location = [[LYAdSDKLocation alloc] init];
    location.latitude = 20.00;// 根据实际情况填写
    location.longitude = 10.00;// 根据实际情况填写
    // 当canUseLocation为NO时，location生效，可以为nil
    privacy.location = location;
    [LYAdSDKConfig initAppId:@"你的APPID" privacy:privacy];
} else {
    [LYAdSDKConfig initAppId:@"你的APPID"];
}
```
### SDK版本号

```objectivec
// 例：2.0.0
NSLog(@"sdkVersion: %@", [LYAdSDKConfig sdkVersion]);
```
### 禁用开屏摇一摇
需要在initAppId之前调用
```objectivec
[LYAdSDKConfig disableSplashAdShake:YES];//是否屏蔽摇⼀摇，false或者不赋值，不屏蔽，true屏蔽
```

## 通知广告

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

## 开屏广告

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
if (...需要自定义底部logo...) {
    CGRect plashFrame = CGRectMake(0, 0, frame.size.width, frame.size.height - 100);
} else {
    CGRect plashFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}
self.splashAd = [[LYSplashAd alloc] initWithFrame:splashFrame slotId:@"你的广告位ID"];
if (...需要自定义底部logo...) {
    CGRect bottomFrame = CGRectMake(0, frame.size.height - 100, frame.size.width, 100);
    UILabel *bottomView = [[UILabel alloc] initWithFrame:bottomFrame];
    [bottomView setText:@"这是一个测试LOGO"];
    bottomView.backgroundColor = [UIColor redColor];
    // 需要在调用loadAd之前设置customBottomView
    self.splashAd.customBottomView = bottomView;
    self.splashAd.tolerateTimeout = 5;//超时时间
}
// 其中self.rootController需要与showAdInWindow时window.rootViewController一致
self.splashAd.viewController = self.rootController;
self.splashAd.delegate = self;
[self.splashAd loadAd];
...
// splash show
// 在收到ly_splashAdDidLoad回调后调用show逻辑
// 展示广告，调用此方法前需调用isValid方法判断广告素材是否有效
[self.splashAd showAdInWindow:keyWindow];
```

## 信息流广告

### 自渲染

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
//在refreshData之后添加view
[self.adView addSubview:your view];
...
省略 具体渲染逻辑，参见demo
...
//重要，最后调用registerDataObjectWithClickableViews注册可点击view
[self.adView registerDataObjectWithClickableViews:@[...]];
```

```objectivec
// LYNativeAdDataObject
typedef NS_ENUM(NSInteger, LYNativeAdCreativeType) {
    LYNativeAdCreativeTypeUnkown = 0,
    
    LYNativeAdCreativeType_ADX_NONE = (1 << 24) | 0,
    LYNativeAdCreativeType_ADX_TXT = (1 << 24) | 1,//TXT 纯文字
    LYNativeAdCreativeType_ADX_IMG = (1 << 24) | 2,//IMG 纯图片
    LYNativeAdCreativeType_ADX_HYBRID = (1 << 24) | 3,//HYBRID 图文混合
    LYNativeAdCreativeType_ADX_VIDEO = (1 << 24) | 4,//VIDEO 视频广告
    LYNativeAdCreativeType_ADX_IMGS = (1 << 24) | 5,//多图

    LYNativeAdCreativeType_GDT_isAppAd = (2 << 24) | 1,//isAppAd
    LYNativeAdCreativeType_GDT_isVideoAd = (2 << 24) | 2,//isVideoAd
    LYNativeAdCreativeType_GDT_isThreeImgsAd = (2 << 24) | 3,//isThreeImgsAd
    LYNativeAdCreativeType_GDT_isWechatCanvasAd = (2 << 24) | 4,//isWechatCanvasAd
    
    LYNativeAdCreativeType_CSJ_SmallImage = (3 << 24) | 2,
    LYNativeAdCreativeType_CSJ_LargeImage = (3 << 24) | 3,
    LYNativeAdCreativeType_CSJ_GroupImage = (3 << 24) | 4,
    LYNativeAdCreativeType_CSJ_VideoImage = (3 << 24) | 5,// video ad || rewarded video ad horizontal screen
    LYNativeAdCreativeType_CSJ_VideoPortrait = (3 << 24) | 15,// rewarded video ad vertical screen
    LYNativeAdCreativeType_CSJ_ImagePortrait = (3 << 24) | 16,
    LYNativeAdCreativeType_CSJ_SquareImage = (3 << 24) | 33,//SquareImage Currently it exists only in the oversea now. V3200 add
    LYNativeAdCreativeType_CSJ_SquareVideo = (3 << 24) | 50,//SquareVideo Currently it exists only in the oversea now. V3200 add
    LYNativeAdCreativeType_CSJ_UnionSplashVideo = (3 << 24) | 154, // Video splash, V3800 add
    LYNativeAdCreativeType_CSJ_UnionVerticalImage = (3 << 24) | 173, // vertical picture
    
    LYNativeAdCreativeType_KS_AdMaterialTypeVideo = (4 << 24) | 1,      // video
    LYNativeAdCreativeType_KS_AdMaterialTypeSingle = (4 << 24) | 2,      // single image
    LYNativeAdCreativeType_KS_AdMaterialTypeAtlas = (4 << 24) | 3,      // multiple image
    
    /// 原生自渲染-横版大图16：9
    LYNativeAdCreativeType_KLN_HorBigImage = (5 << 24) | 1001,
    /// 原生自渲染-横版视频16：9
    LYNativeAdCreativeType_KLN_HorVideo = (5 << 24) | 1002,
    
    LYNativeAdCreativeType_BD_NORMAL = (6 << 24) | 0, // 一般图文或图片广告
    LYNativeAdCreativeType_BD_VIDEO = (6 << 24) | 1, // 视频广告，需开发者增加播放器支持
    LYNativeAdCreativeType_BD_HTML = (6 << 24) | 2, // html模版广告
    LYNativeAdCreativeType_BD_GIF = (6 << 24) | 3, //GIF广告
    
    LYNativeAdCreativeType_GRO_Unknown = (7 << 24) | 0,
    LYNativeAdCreativeType_GRO_SmallImage = (7 << 24) | 2,
    LYNativeAdCreativeType_GRO_LargeImage = (7 << 24) | 3,
    LYNativeAdCreativeType_GRO_GroupImage = (7 << 24) | 4,
    LYNativeAdCreativeType_GRO_LandscapeVideo = (7 << 24) | 5,// video ad || rewarded video ad horizontal screen
    LYNativeAdCreativeType_GRO_PortraitVideo = (7 << 24) | 15,// rewarded video ad vertical screen
    LYNativeAdCreativeType_GRO_PortraitImage = (7 << 24) | 16,
};

typedef NS_ENUM(NSInteger, LYNativeAdInteractionType) {
    LYNativeAdInteractionTypeUnkown = 0,
    LYNativeAdInteractionTypeBrowser = 1,
    LYNativeAdInteractionTypeDownload = 2,
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
// 交互类型，返回LYNativeAdInteractionType中的值
@property (nonatomic, readonly) LYNativeAdInteractionType interactionType;
@property (nonatomic, strong) LYVideoConfig *videoConfig;
@end
```

### 模板渲染

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

## 激励视频广告

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
// 展示广告，调用此方法前需调用isValid方法判断广告素材是否有效
[self.rewardedAd showAdFromRootViewController:self];
```

## 插屏广告

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
self.interstitial.videoMuted = YES; // 自动播放时，是否静音。默认 YES。loadAd 前设置。
self.interstitial.delegate = self;
[self.interstitial loadAd];
...
// interstitial show，在收到加载成功回调之后调用show方法
// 展示广告，调用此方法前需调用isValid方法判断广告素材是否有效
[self.interstitial showAdFromRootViewController:self];
```

## Banner广告

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

如果想自定义Banner的刷新间隔，可以通过autoSwitchInterval来进行设置。所设置值的有效范围是[30,120]。默认为30。设 0 则不刷新。只对广点通、穿山甲有效

```objectivec
self.bannerView.autoSwitchInterval = 30;
```

## 全屏视频广告

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
// 展示广告，调用此方法前需调用isValid方法判断广告素材是否有效
[self.fullScreenVideoAd showAdFromRootViewController:self];
```

## Draw视频广告

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

## 视频内容

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

## 入口组件

参考demo

## 实时竞价
### 支持场景
* 开屏广告
* 模板渲染广告
* 自渲染广告
* 插屏半屏/全屏广告
* 激励视频广告
* banner 广告
### 接入方式
#### 能力调用
乐游广告竞胜之后调用 sendWinNotificationWithInfo: 接口
乐游广告竞败之后或未参竞调用 sendLossNotificationWithInfo: 接口
#### 协议接口
```objectivec
/**
 * 竞价失败原因
 */
typedef NS_ENUM(NSInteger, LYAdBiddingLossReason) {
    LYAdBiddingLossReasonOther                   = 10001,    // 其他
    LYAdBiddingLossReasonLowPrice                = 1,        // 竞争力不足
    LYAdBiddingLossReasonLoadTimeout             = 2,        // 返回超时
    LYAdBiddingLossReasonNoAd                    = 3,        // 无广告回包
    LYAdBiddingLossReasonAdDataError             = 4,        // 回包不合法
    LYAdBiddingLossReasonAdSuccNoBid             = 5,        // 有回包但未竞价
    LYAdBiddingLossReasonMediaBasePriceFilter    = 6,        // 媒体侧底价过滤
    LYAdBiddingLossReasonCacheInvalid            = 7,        // 缓存失效
    LYAdBiddingLossReasonExposurePriorityReduce  = 8,        // 曝光优先级降低
};
/**
 * AdnType
 */
typedef NS_ENUM(NSUInteger, LYAdAdnType) {
    LYAdAdnTypeSelfSale         = -1,    // 输给自售广告主
    LYAdAdnTypeOther            = 0,
    LYAdAdnTypeGDT              = 2,
    LYAdAdnTypeBaidu            = 8,
    LYAdAdnTypeKS               = 10,
};
/**
 *  竞胜之后调用, 需要在调用广告 show 之前调用
 *
 *  @param winInfo 竞胜信息，字典类型，必填，支持的key为以下内容。注：key是个宏，在LYAdSDKConfig.h中有定义
 *  LY_M_W_E_COST_PRICE：竞胜价格 (单位: 分)，必填。值类型为NSNumber *
 *  LY_M_W_H_LOSS_PRICE：最高失败出价，必填。值类型为NSNumber *
 *
 */
 - (void)sendWinNotificationWithInfo:(NSDictionary *)winInfo;    
/**
*  竞败之后或未参竞调用
 *
 *  @pararm lossInfo 竞败信息，字典类型，必填，支持的key为以下内容。注：key是个宏，在LYAdSDKConfig.h中有定义
 *  LY_M_L_WIN_PRICE ：竞胜价格 (单位: 分)，必填。值类型为NSNumber *
 *  LY_M_L_LOSS_REASON ：优量汇广告竞败原因，必填。竞败原因参考枚举LYAdBiddingLossReason中的定义，值类型为NSNumber *
 *  LY_M_ADN_IS_BID ：参与竞价的是否是竞价，必填。值类型为NSNumber *，@(YES)或者@(NO)
 *  LY_M_ADN_TYPE ：竞胜方渠道类型，必填。值类型为NSNumber *，@(LYAdAdnType)
 *         LYAdAdnTypeSelfSale - 输给自售广告主，当自售广告源报价为本次竞价的最高报价时，可上报此值，仅对有自售广告源的开发者使用；
 *         LYAdAdnTypeOther - 输给第三方ADN，当其它ADN报价为本次竞价的最高报价时，可上报此值；
 *         LYAdAdnTypeGDT - 输给优量汇其他广告位，当优量汇其他广告位报价为本次竞价的最高报价时，可上报此值；
 *         LYAdAdnTypeBaidu - 输给百度其他广告位，当百度其他广告位报价为本次竞价的最高报价时，可上报此值；
 *         LYAdAdnTypeKS - 输给快手其他广告位，当快手其他广告位报价为本次竞价的最高报价时，可上报此值；
 * LY_M_ADN_NAME ：当LY_M_ADN_TYPE为LYAdAdnTypeOther时，必填。值类型为NSString *
 */
- (void)sendLossNotificationWithInfo:(NSDictionary *)lossInfo; 
```

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
