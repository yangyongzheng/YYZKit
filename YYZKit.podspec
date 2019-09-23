Pod::Spec.new do |s|

  # ――― required ――― #
  s.name = "YYZKit"
  s.version = "1.0.0"
  s.author = { "yangyongzheng" => "youngyongzheng@qq.com" }
  # s.authors = { "yangyongzheng" => "youngyongzheng@qq.com", "yyz" => "yangyongzheng@cnhnkj.com" }
  s.license = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.homepage = "https://github.com/yangyongzheng/YYZKit"
  s.source = { :git => "https://github.com/yangyongzheng/YYZKit.git", :tag => "#{s.version}" }
  # :git => :tag, :branch, :commit, :submodules
  s.summary = "公共基础套件."

  # ――― Optional ――― #
  s.description  = <<-DESC
                      公共基础套件，包含了常用工具类和常用组件封装。
                   DESC
  s.platform = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.requires_arc = true
  # s.dependency "AFNetworking", "~> 3.2.1"
  # s.framework = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.weak_framework = "Twitter"
  # s.weak_frameworks = "Twitter", "SafariServices"
  # s.library = "iconv"
  # s.libraries = "iconv", "xml2"
  s.source_files  = "Classes/YYZKitHeader.h"
  # s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.public_header_files = "Classes/YYZKitHeader.h"
  # s.ios.resource_bundle = { "MapBox" => "MapView/Map/Resources/*.png" }
  # s.resource_bundles = {
  #   "MapBox" => ["MapView/Map/Resources/*.png"],
  #   "MapBoxOtherResources" => ["MapView/Map/OtherResources/*.png"]
  # }

  # ――― Subspecs ――― #
  s.subspec "Foundation" do |fs|
    fs.source_files = "Classes/Foundation/**/*.{h,m}"
    fs.public_header_files = "Classes/Foundation/**/*.h"
  end

  s.subspec "UIKit" do |ks|
    ks.dependency "Classes/Foundation"
    ks.source_files = "Classes/UIKit/**/*.{h,m}"
    ks.public_header_files = "Classes/UIKit/**/*.h"
    # ks.ios.resource_bundle = { "UEKKitNib" => "UEKKit/Controls/**/*.xib" }
  end

end
