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
#  pod 'LYAdSDKAdapterForCSJ', '2.6.5' # 穿山甲支持，当接入穿山甲SDK跑穿山甲或者接入穿山甲融合SDK只跑穿山甲时使用，不与LYAdSDKAdapterForGromore同时存在。
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
