Pod::Spec.new do |s|
  s.name         = "SICategory"
  s.version      = "1.5"
  s.summary      = "iOS Category."
  s.description  = <<-DESC
                      A collection of iOS Category.
                   DESC

  s.homepage     = "https://github.com/silence0201/iOS-Category"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Silence" => "374619540@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/silence0201/iOS-Category.git", :tag => "1.5" }
  s.public_header_files = 'Classes/SICategory.h'
  s.source_files = 'Classes/SICategory.h'
  s.requires_arc = true

  s.subspec 'SIUIKit' do |ss|
    ss.source_files = 'Classes/UIKit/**/*.{h,m}'
    ss.public_header_files = 'Classes/UIKit/**/*.{h}'
  end

  s.subspec 'SIFoundation' do |ss|
    ss.source_files = 'Classes/Foundation/**/*.{h,m}'
    ss.public_header_files = 'Classes/Foundation/**/*.{h}'
  end

  s.subspec 'SIMacros' do |ss|
    ss.source_files = 'Classes/Macros/**/*.{h,m}'
    ss.public_header_files = 'Classes/Macros/**/*.{h}'
  end

end
