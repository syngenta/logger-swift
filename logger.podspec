#
# Be sure to run `pod lib lint logger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'logger'
  s.version          = `git describe --abbrev=0 --tags`
  s.summary          = 'Library for structuring logs'
  s.description      = 'You can print fatal, warning, success and your own log. Library add file name, line, function name and emoji for fast error finding'
  s.homepage         = 'https://github.com/lumyk/logger'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Evgeny Kalashnikov' => 'lumyk@me.com' }
  s.source           = { :git => 'https://github.com/lumyk/logger.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/**/*'
end
