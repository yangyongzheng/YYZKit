# 需要生成的workspace的名称
workspace 'YYZWorkspace'

# project 'path' 指定包含Pods库应链接的目标的Xcode项目，其中path为项目链接的路径
project 'YYZKit/YYZKit'  # 核心模块
project 'YYZMainProj/YYZMainProj'      # 主体工程

platform :ios, '9.0'
inhibit_all_warnings!  # 禁止CocoaPods库中的所有警告

# This Target can be found in a Xcode project called `YYZKit`
target 'YYZKit' do
    project 'YYZKit/YYZKit'
    pod 'FMDB'
    
    target 'YYZKitTests' do
        inherit! :search_paths
    end
end

# Same Podfile, multiple Xcodeprojects
target 'YYZMainProj' do
    project 'YYZMainProj/YYZMainProj'

    pod 'SDWebImage', '~> 5.8.1'
    pod 'AFNetworking', '~> 4.0.1'

    target 'YYZMainProjTests' do
        inherit! :search_paths
    end
end
