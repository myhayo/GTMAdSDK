#
# Be sure to run `pod lib lint GTMAdSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GTMAdSDK'
  s.version          = '1.1.2'
  s.summary          = '火眼聚合广告SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
火眼聚合广告SDK_iOS
                       DESC

  s.homepage         = 'https://github.com/myhayo/GTMAdSDK.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aaslte' => 'raobinlin@myhayo.com' }
  s.source           = { :git => 'https://github.com/myhayo/GTMAdSDK.git', :tag => s.version.to_s }
  s.platform         = :ios, "9.0"
  s.frameworks       = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate'
  s.libraries        = 'c++', 'resolv', 'z', 'sqlite3', 'xml2'
  
  s.ios.vendored_frameworks = 'lib/GTMAdSDK.framework'
  s.ios.resource = 'lib/GTMAdSDK.framework/MHAdResource.bundle'
  s.xcconfig     = {'OTHER_LDFLAGS' => '-ObjC'}
  s.static_framework = true
  s.dependency 'GDTMobSDK'
  # s.dependency 'Bytedance-UnionAD'
  # 新版本头条SDK
  s.dependency 'Ads-CN'
  # SigmobAd平台限制版本 因为2.23.1以后该sdk内没有全屏视频广告
  s.dependency 'SigmobAd-iOS', '~> 2.25.1'
  valid_archs = ['armv7', 'armv7s', 'x86_64', 'arm64']
  s.xcconfig = {
    'VALID_ARCHS' =>  valid_archs.join(' '),
  }
  
end
