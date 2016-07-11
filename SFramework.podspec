#
# Be sure to run `pod lib lint SFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'SFramework'
s.version          = '0.0.1'
s.summary          = 'Sattar personal framework.'
s.description      = <<-DESC
This framework will be used as a helper to help us make projects faster and easier.
DESC

s.homepage         = 'https://github.com/SattarFalahati/SFramework'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Sattar Falahati' => 'sattar.falahati@gmail.com' }
s.source           = { :git => 'https://github.com/SattarFalahati/SFramework.git', :tag => s.version.to_s }
s.ios.deployment_target = '8.0'
s.source_files = 'SFramework/**/**/*'

s.preserve_paths = 'SFramework'

# s.frameworks = 'UIKit'
s.dependency 'AFNetworking', '~> 2.6.3'
s.dependency 'MBProgressHUD', '~> 0.9.2'


# s.resource_bundles = {
#   'SFramework' => ['SFramework/Assets/*.png']
# }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
# s.public_header_files = 'Pod/Classes/**/*.h'


end
