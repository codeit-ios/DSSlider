Pod::Spec.new do |s|
  s.name = 'DSSlider'
  s.version = '0.0.4'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Fully customized Double Sided Slide to Unlock Control, written on Swift under the short name - DSSlider'
  s.homepage = 'https://github.com/codeit-ios/DSSlider'
  s.authors = { 'Konstantin Stolyarenko' => 'kostiantyn.stoliarenko@codeit.pro' }
  s.source = { :git => 'https://github.com/codeit-ios/DSSlider.git', :tag => s.version }
  s.documentation_url = 'https://github.com/codeit-ios/DSSlider/blob/master/README.md'
  s.ios.deployment_target = '10.0'
  s.swift_versions = ['5.0', '5.1']
  s.source_files = 'Source/*.swift'
end
