#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint purchases_ui_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'purchases_ui_flutter'
  s.version          = '8.11.0'
  s.summary          = 'Flutter plugin that integrates RevenueCat Paywalls'
  s.description      = <<-DESC
Flutter plugin that integrates RevenueCat Paywalls
                       DESC
  s.homepage         = 'http://revenuecat.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'RevenueCat' => 'support@revenuecat.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.dependency 'PurchasesHybridCommonUI', '14.3.0'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
