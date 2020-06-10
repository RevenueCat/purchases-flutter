#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'purchases_flutter'
  s.version          = '1.1.1'
  s.summary          = 'Cross-platform subscriptions framework for Flutter.'
  s.description      = <<-DESC
  Client for the RevenueCat subscription and purchase tracking system, making implementing in-app subscriptions in Flutter easy - receipt validation and status tracking included!
                       DESC
  s.homepage         = 'http://revenuecat.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'RevenueCat' => 'support@revenuecat.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'PurchasesHybridCommon', '1.3.0'
  s.ios.deployment_target = '9.0'
end

