#
# Be sure to run `pod lib lint BNSss.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ThenMoya'
  s.version          = '0.0.1'
  s.summary          = 'The Basic Moya Map Framework'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ghostcrying/ThenMoya'
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.author           = { 'ghost' => 'czios1501@gmail.com' }
  s.source           = { :git => 'https://github.com/ghostcrying/ThenMoya.git', :tag => s.version.to_s }
  
  s.platforms     = { :ios => "11.0", :osx => "10.15", :tvos => "12.0", :watchos => "4.0" }
  s.swift_version = "5.0"

  s.source_files = 'Sources/**/*.swift'
  s.frameworks = 'Foundation'
  s.dependency "Moya", '~> 14.0.0'
end

