#
# Be sure to run `pod lib lint DryAlipay-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
# 提交仓库:
# pod spec lint DryAlipay-iOS.podspec --allow-warnings --use-libraries
# pod trunk push DryAlipay-iOS.podspec --allow-warnings --use-libraries
#

Pod::Spec.new do |s|
  
  # Git
  s.name        = 'DryAlipay-iOS'
  s.version     = '0.0.1'
  s.summary     = 'DryAlipay-iOS'
  s.homepage    = 'https://github.com/duanruiying/DryAlipay-iOS'
  s.license     = { :type => 'MIT', :file => 'LICENSE' }
  s.author      = { 'duanruiying' => '2237840768@qq.com' }
  s.source      = { :git => 'https://github.com/duanruiying/DryAlipay-iOS.git', :tag => s.version.to_s }
  s.description = <<-DESC
  TODO: iOS简化支付宝支付.
  DESC
  
  # User
  #s.swift_version          = '5'
  s.ios.deployment_target   = '10.0'
  s.requires_arc            = true
  s.user_target_xcconfig    = {'OTHER_LDFLAGS' => ['-w']}
  
  # Pod
  s.static_framework        = true
  s.pod_target_xcconfig     = {'OTHER_LDFLAGS' => ['-w']}
  
  # Code
  s.source_files        = 'DryAlipay-iOS/Classes/Code/**/*'
  s.public_header_files = 'DryAlipay-iOS/Classes/Code/Public/**/*.h'
  
  # System
  s.libraries  = 'z', 'c++'
  s.frameworks = 'UIKit', 'Foundation', 'CoreMotion', 'CFNetwork', 'CoreGraphics', 'CoreText', 'QuartzCore', 'CoreTelephony', 'SystemConfiguration'
  
  # ThirdParty
  #s.vendored_libraries  = ''
  
  # (本地导入)
  #s.vendored_frameworks = 'DryAlipay-iOS/Classes/Frameworks/*.framework'
  #s.resources = 'DryAlipay-iOS/Classes/Bundle/*.bundle'
  #s.dependency 'UTDID'
  # (远程导入)
  s.dependency 'AlipaySDK-iOS'
  
end
