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
#  pod 'Ads-CN-Beta', '5.8.0.8'
#  pod 'Ads-Fusion-CN-Beta','6.0.1.3', :subspecs => ['BUAdSDK', 'CSJMediation']
  pod 'Ads-Fusion-CN-Beta', :path => '../ThirdPartySDK/Ads-Fusion-CN-Beta/6.1.0.3/', :subspecs => ['BUAdSDK', 'CSJMediation']
  pod 'GDTMobSDK', '4.14.76'
  pod 'BaiduMobAdSDK', '5.35'
  pod 'KSAdSDK', '3.3.64.4'
  # KSAdSDKFull、JADYun，没有提交到官方库，需要引入LYSpecs私库拉取
#  pod 'fork-KSAdSDKFull', '3.3.32'
  pod 'fork-JADYun' , '2.5.8'
  
  pod 'LYAdSDK', '2.6.5.1'
  pod 'LYAdSDKAdapterForCSJ', '2.6.1' # 穿山甲支持
  pod 'LYAdSDKAdapterForGDT', '2.6.4' # 广点通支持
  pod 'LYAdSDKAdapterForKS', '2.6.4' # 快手AD支持
#  pod 'LYAdSDKAdapterForKSContent', '2.5.0' # 快手内容支持
  pod 'LYAdSDKAdapterForBD', '2.6.3' # 百度支持
  pod 'LYAdSDKAdapterForJD', '2.6.5' # 京东支持
  pod 'LYAdSDKAdapterForGromore', '2.6.3' # Gromore支持
  
  # 以下库仅在Dmeo中使用
  pod 'Masonry', '~> 1.1.0'
  pod 'MMKV', '~> 1.2.15'
  pod 'SVProgressHUD', '~> 2.2.5'
  project 'LYAdSDKDemo'
end
