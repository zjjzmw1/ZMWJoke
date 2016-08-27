platform :ios, '9.0'
use_frameworks!

target ‘ZMWJoke’ do

#GitHub上最为开发者认可的JSON解析类
#pod 'SGYSwiftJSON', '~> 1.1.3'
#代替GCD 简洁的后台执行代码封装库
#pod 'AsyncSwift', '~> 1.7.3'
# 著名的AFNetworking网络基础库Swift语言版
#pod 'Alamofire', '~> 3.4'
pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :branch => 'swift3'
# HanekeSwift：轻量带缓存高性能图片加载组件
#pod 'HanekeSwift', '~> 0.10.1'
# log
#pod 'Log', '~> 0.5'
end 

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
