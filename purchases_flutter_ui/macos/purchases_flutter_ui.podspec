#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint purchases_flutter_ui.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'purchases_flutter_ui'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin that integrates RevenueCat Paywalls'
  s.description      = <<-DESC
Flutter plugin that integrates RevenueCat Paywalls
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.dependency 'PurchasesHybridCommon', '8.10.0-beta.8'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
