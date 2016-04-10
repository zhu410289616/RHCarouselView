Pod::Spec.new do |s|

  s.name         = "RHCarouselView"
  s.version      = "1.0.0"
  s.summary      = "RHCarouselView and Demo"
  s.homepage     = "https://github.com/zhu410289616/RHCarouselView"
  s.license      = { :type => "Apache", :file => "LICENSE" }
  s.author       = { "zhu410289616" => "zhu410289616@163.com" }

  s.ios.deployment_target = "6.0"
  
  s.source       = { :git => "https://github.com/zhu410289616/RHCarouselView.git", :tag => s.version.to_s }

  s.source_files  = "RHCarouselView/*.{h,m}" 
  s.requires_arc = true

end
