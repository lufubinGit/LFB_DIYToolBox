Pod::Spec.new do |s|
  s.name             = "LFB_DIY_Tool"
  s.version          = "1.0.0"
  s.summary          = "A tool used on iOS."
  s.description      = <<-DESC
                       这是卢赋斌先生的一个工具库
                       DESC
  s.homepage         = "https://github.com/lufubinGit/LFB_DIYToolBox.git"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "jeikerxiao" => "jeiker@126.com" }
  s.source           = { :git => "https://github.com/jeikerxiao/XXFramework.git", :tag => s.version }
  # s.social_media_url = 'https://twitter.com/NAME'

  s.platform     = :ios
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  #s.source_files = 'WZMarqueeView/*'
  # s.resources = 'Assets'

  # s.ios.exclude_files = 'Classes/osx'
  # s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  s.vendored_frameworks = 'Framework.framework'
  s.frameworks = 'Foundation'


end
