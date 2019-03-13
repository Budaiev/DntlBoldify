#
# Be sure to run `pod lib lint DntlBoldify.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DntlBoldify'
  s.version          = '0.1.3'
  s.summary          = 'Category for NSAttributesString. Apply needed attributes for tagged text'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Usefull for cases when you have different attributes for Localizable.strings.
  Convenient to work with same texts for other targets in the project.
                       DESC

  s.homepage         = 'https://github.com/Budaiev/DntlBoldify'
  s.screenshots     = 'http://github.com/Budaiev/DntlBoldify/blob/master/Example/DntlBoldify/screenshots/demo.jpg'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aleksandr Budaiev' => 'budaiev@dnt-lab.com' }
  s.source           = { :git => 'https://github.com/Budaiev/DntlBoldify.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DntlBoldify/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DntlBoldify' => ['DntlBoldify/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
