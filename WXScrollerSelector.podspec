
Pod::Spec.new do |s|
  s.name             = 'WXScrollerSelector'
  s.version          = '0.1.2'
  s.summary          = 'WXScrollerSelector.'

  s.description      = "WXScrollerSelector滑动选择器"

  s.homepage         = 'https://github.com/suwenxiao/WXScrollerSelector.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '714350220@qq.com' => '714350220@qq.com' }
  s.source           = { :git => 'https://github.com/suwenxiao/WXScrollerSelector.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WXScrollerSelector/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WXScrollerSelector' => ['WXScrollerSelector/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
end
