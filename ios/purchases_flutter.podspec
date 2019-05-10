#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'purchases_flutter'
  s.version          = '0.0.1'
  s.summary          = 'Cross-platform subscriptions framework for Flutter.'
  s.description      = <<-DESC
Cross-platform subscriptions framework for Flutter.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Purchases', '~> 2.3.0'

  s.ios.deployment_target = '9.0'
end

