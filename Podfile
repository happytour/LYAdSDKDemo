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
  pod 'Ads-CN', '4.1.0.2'
  pod 'GDTMobSDK', '4.13.22'
  pod 'SigmobAd-iOS', '3.4.3'
  pod 'BaiduMobAdSDK', '4.81'
  pod 'WechatOpenSDK', '1.8.7.1'
  pod 'KSAdSDK', '3.3.22' # 快手AD官方（不能与KSAdSDKFull同时存在）
  # KSAdSDKFull、QySdk、JADYun、KlevinAdSDK，没有提交到官方库，需要引入LYSpecs私库拉取
  pod 'fork-QySdk', '1.3.2'
  pod 'fork-JADYun' , '1.3.4'
  pod 'fork-KlevinAdSDK', '2.4.1.222'
#  pod 'fork-KSAdSDKFull', '3.3.24.1' # 快手内容私库（不能与KSAdSDK同时存在）
  
  pod 'LYAdSDK', '2.4.1'
  pod 'LYAdSDKAdapterForCSJ', '2.3.4'
  pod 'LYAdSDKAdapterForGDT', '2.3.3'
  pod 'LYAdSDKAdapterForSIG', '2.4.1'
  pod 'LYAdSDKAdapterForIQY', '2.3.0'
  pod 'LYAdSDKAdapterForBD', '2.4.1'
  pod 'LYAdSDKAdapterForJD', '2.3.0'
  pod 'LYAdSDKAdapterForKLN', '2.4.1'
  pod 'LYAdSDKAdapterForKS', '2.4.1.1' # 快手AD支持
#  pod 'LYAdSDKAdapterForKSContent', '2.4.1.1' # 快手内容支持
  project 'LYAdSDKDemo'
end
