# Uncomment the next line to define a global platform for your project
# CocoaPods官方库
#source 'https://github.com/CocoaPods/Specs.git'
# 清华大学镜像库，如果上面库无法加载请使用下面镜像
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
# 添加LYSpecs私库
source 'https://gitee.com/happytour/LYSpecs.git'

platform :ios, '9.0'

workspace 'LYAdSDKDemo'
project 'LYAdSDKDemo'

target 'LYAdSDKDemo' do
  pod 'Ads-CN', '4.7.1.1' # 穿山甲官方
  pod 'GDTMobSDK', '4.13.84' # 广点通官方
  pod 'SigmobAd-iOS', '4.2.1' # sigmob官方
  pod 'BaiduMobAdSDK', '4.89' # 百度官方
  pod 'WechatOpenSDK', '1.8.7.1' # 微信官方
#  pod 'KSAdSDK', '3.3.31' # 快手AD官方（不能与KSAdSDKFull同时存在）
  # KSAdSDKFull、QySdk、JADYun、KlevinAdSDK、Ads-Mediation-CN、ABUAdCsjAdapter，没有提交到官方库，需要引入LYSpecs私库拉取
  pod 'fork-KSAdSDKFull', '3.3.28' # 快手内容私库（不能与KSAdSDK同时存在）
  pod 'fork-QySdk', '1.3.2' # 爱奇艺私库
  pod 'fork-JADYun' , '2.0.2' # 京东私库
  pod 'fork-KlevinAdSDK', '2.4.1.222' # 游可赢私库
  pod 'fork-Ads-Mediation-CN', '3.6.0.4' # GroMore私库
  pod 'fork-ABUAdCsjAdapter', '4.7.0.7.0' # GroMore Csj支持私库
  
  pod 'LYAdSDK', '2.5.5'
  pod 'LYAdSDKAdapterForCSJ', '2.5.5' # 穿山甲支持
  pod 'LYAdSDKAdapterForGDT', '2.5.5' # 广点通支持
  pod 'LYAdSDKAdapterForKS', '2.5.5' # 快手AD支持
  pod 'LYAdSDKAdapterForKSContent', '2.5.0' # 快手内容支持
  pod 'LYAdSDKAdapterForSIG', '2.5.0' # sigmob支持
  pod 'LYAdSDKAdapterForIQY', '2.5.0' # 爱奇艺支持
  pod 'LYAdSDKAdapterForBD', '2.5.5' # 百度支持
  pod 'LYAdSDKAdapterForJD', '2.5.5.2' # 京东支持
  pod 'LYAdSDKAdapterForKLN', '2.5.5' # 游可赢支持
  pod 'LYAdSDKAdapterForGromore', '2.5.5' # Gromore支持
  project 'LYAdSDKDemo'
end
