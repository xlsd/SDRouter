
Pod::Spec.new do |s|

s.name         = "SDRouter"
s.version      = "1.0.0"
s.ios.deployment_target = '8.0'
s.summary      = "SDRouter."
s.description  = "iOS Router to module decoupling"
s.homepage     = "https://github.com/giveMeHug/SDRouter/tree/master/SDRouter"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "as_one" => "413890968@qq.com" }
s.source       = { :git => "https://github.com/giveMeHug/SDRouter/tree/master/SDRouter.git", :tag => s.version }
s.source_files = "*.{h,m}"
s.requires_arc = true
end
