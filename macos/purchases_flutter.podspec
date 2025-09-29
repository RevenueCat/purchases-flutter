#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint purchases_flutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'purchases_flutter'
  s.version          = '8.11.0'
  s.summary          = 'Cross-platform subscriptions framework for Flutter.'
  s.description      = <<-DESC
  Client for the RevenueCat subscription and purchase tracking system, making implementing in-app subscriptions in Flutter easy - receipt validation and status tracking included!
                       DESC
  s.homepage         = 'http://revenuecat.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'RevenueCat' => 'support@revenuecat.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'FlutterMacOS'
  s.dependency 'PurchasesHybridCommon', '14.3.0'
  s.platform = :osx, '10.12'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
  s.static_framework = true
end
