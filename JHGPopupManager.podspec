Pod::Spec.new do |spec|

  spec.name         = "JHGPopupManager"
  spec.version      = "1.0.0"
  spec.summary      = "弹窗管理器."
  spec.description  = "弹窗管理器."
  spec.homepage     = "https://github.com/xq-120/JHGPopupManager"

  spec.license      = "MIT"

  spec.author       = { "uzzi" => "1204556447@qq.com" }
  
  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/xq-120/JHGPopupManager.git", :tag => "#{spec.version}" }
  
  spec.subspec 'Protocol' do |ss|
    ss.source_files = 'JHGPopupManager/Protocol/JHGPopupManagerItemProtocol.swift'
  end
  
  spec.subspec 'Core' do |ss|
    ss.dependency 'JHGPopupManager/Protocol'
    ss.dependency "JHGPopupKit/Utils", '~> 1.8.0'
    ss.source_files = 'JHGPopupManager/Core/*.{swift}'
  end
  
  spec.subspec 'JHGPopupKitSupport' do |ss|
    ss.dependency 'JHGPopupManager/Protocol'
    ss.dependency 'JHGPopupKit', '~> 1.8.0'
    ss.source_files = 'JHGPopupManager/JHGPopupKitSupport/JHGPopupKitSupport.swift'
  end

  spec.frameworks   = "Foundation", "UIKit"

  spec.requires_arc = true
  spec.swift_versions = ['5.0']
  
end
