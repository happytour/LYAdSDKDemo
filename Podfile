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
  pod 'Ads-CN', '5.3.0.3' # 穿山甲官方
  pod 'GDTMobSDK', '4.14.30' # 广点通官方
  pod 'SigmobAd-iOS', '4.2.1' # sigmob官方
  pod 'BaiduMobAdSDK', '4.901' # 百度官方
  pod 'WechatOpenSDK', '1.8.7.1' # 微信官方
  pod 'KSAdSDK', '3.3.44' # 快手AD官方（不能与KSAdSDKFull同时存在）
  # KSAdSDKFull、JADYun、Ads-Mediation-CN、ABUAdCsjAdapter，没有提交到官方库，需要引入LYSpecs私库拉取
#  pod 'fork-KSAdSDKFull', '3.3.28' # 快手内容私库（不能与KSAdSDK同时存在）
  pod 'fork-JADYun' , '2.0.2' # 京东私库
  pod 'fork-Ads-Mediation-CN', '4.2.0.2' # GroMore私库
  pod 'fork-ABUAdCsjAdapter', '5.3.0.3.0' # GroMore Csj支持私库
  
  pod 'LYAdSDK', '2.5.18'
  pod 'LYAdSDKAdapterForCSJ', '2.5.18' # 穿山甲支持
  pod 'LYAdSDKAdapterForGDT', '2.5.16' # 广点通支持
  pod 'LYAdSDKAdapterForKS', '2.5.18' # 快手AD支持
#  pod 'LYAdSDKAdapterForKSContent', '2.5.0' # 快手内容支持
  pod 'LYAdSDKAdapterForSIG', '2.5.0' # sigmob支持
  pod 'LYAdSDKAdapterForBD', '2.5.16' # 百度支持
  pod 'LYAdSDKAdapterForJD', '2.5.8.2' # 京东支持
  pod 'LYAdSDKAdapterForGromore', '2.5.8.1' # Gromore支持
  
  # 以下库仅在Dmeo中使用
  pod 'Masonry', '~> 1.1.0'
  pod 'MMKV', '~> 1.2.15'
  pod 'SVProgressHUD', '~> 2.2.5'
  project 'LYAdSDKDemo'
end
