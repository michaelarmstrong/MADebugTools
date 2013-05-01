Pod::Spec.new do |s|
  s.name         = "MADebugTools"
  s.version      = "0.0.1"
  s.summary      = "A set of Categories for Debugging iOS Apps MADebugTools."
  s.homepage     = "http://mike.kz/services/instantly-gain-insight-on-someone-elses-ios-app-architecture-with-madebugtools/"
  s.license      = 'MIT (example)'
  s.author       = { "Michael Armstrong" => "mich@el.cx" }
  s.source       = { :git => "https://github.com/michaelarmstrong/MADebugTools.git", :tag => "0.0.2" }

  s.platform     = :ios, '5.0'

  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'

  s.requires_arc = true
end
