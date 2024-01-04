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
  pod 'Ads-Fusion-CN-Beta','5.9.0.1', :subspecs => ['BUAdSDK', 'CSJMediation']
  pod 'GDTMobSDK', '4.14.60'
  pod 'BaiduMobAdSDK', '5.332'
  pod 'KSAdSDK', '3.3.57'
  # KSAdSDKFull、JADYun，没有提交到官方库，需要引入LYSpecs私库拉取
#  pod 'fork-KSAdSDKFull', '3.3.32'
  pod 'fork-JADYun' , '2.5.4'
  
  pod 'LYAdSDK', '2.6.3'
  pod 'LYAdSDKAdapterForCSJ', '2.6.1' # 穿山甲支持
  pod 'LYAdSDKAdapterForGDT', '2.6.3' # 广点通支持
  pod 'LYAdSDKAdapterForKS', '2.6.3' # 快手AD支持
#  pod 'LYAdSDKAdapterForKSContent', '2.5.0' # 快手内容支持
  pod 'LYAdSDKAdapterForBD', '2.6.3' # 百度支持
  pod 'LYAdSDKAdapterForJD', '2.6.1' # 京东支持
  pod 'LYAdSDKAdapterForGromore', '2.6.1' # Gromore支持
  
  # 以下库仅在Dmeo中使用
  pod 'Masonry', '~> 1.1.0'
  pod 'MMKV', '~> 1.2.15'
  pod 'SVProgressHUD', '~> 2.2.5'
  project 'LYAdSDKDemo'
end
