Pod::Spec.new do |s|  
  s.name             = "DDMISDK"  
  s.version          = "1.0.0"  
  s.summary          = "mi auth sdk with ui"  
  s.homepage         = "https://github.com/393385724/DDMISDKDemo"  
  s.license          = 'MIT'  
  s.author           = { "llg" => "393385724@qq.com" }  
  s.source           = { :git => "https://github.com/393385724/DDMISDKDemo.git", :tag => s.version.to_s }  
  
  s.platform     = :ios, '7.0'  
  s.ios.deployment_target = '7.0'  
  s.requires_arc = true  

  s.ios.source_files = 'DDMISDK/Classes/*.{m,h}'  
  s.ios.public_header_files = 'DDMISDK/Classes/DDMIHandler.h','DDMISDK/Classes/DDMIUserInfoItem.h','DDMISDK/Classes/DDMIHandler.h'
  s.ios.resources = ['DDMISDK/Resource/*.xib','DDMISDK/Resource/*.xcassets','DDMISDK/Resource/*.lproj']
  s.ios.vendored_frameworks = 'DDMISDK/*.framework'
  s.libraries = 'stdc++'  
end  
