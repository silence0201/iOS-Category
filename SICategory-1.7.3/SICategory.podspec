Pod::Spec.new do |s|
  s.name = "SICategory"
  s.version = "1.7.3"
  s.summary = "iOS Category."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Silence"=>"374619540@qq.com"}
  s.homepage = "https://github.com/silence0201/iOS-Category"
  s.description = "A collection of iOS Category."
  s.frameworks = "StoreKit"
  s.requires_arc = true
  s.source = { :path => '.' }

  s.ios.deployment_target    = '7.0'
  s.ios.vendored_framework   = 'ios/SICategory.framework'
end
