# 多工程联编Podfile文件配置

# 需要生成的workspace的名称
workspace 'YYZWorkspace'

# project 'path' 指定包含Pods库应链接的目标的Xcode项目，其中path为项目链接的路径
# 对于1.0之前的版本，请使用xcodeproj
project 'YYZKit/YYZKit'  # 核心模块
project 'YYZMainProj/YYZMainProj'      # 主体工程

platform :ios, '8.0'
inhibit_all_warnings!  # 禁止CocoaPods库中的所有警告

def commonPods
    pod 'FMDB'
end

# This Target can be found in a Xcode project called `YYZKit`
# 核心模块工程需要引入的第三方库
target 'YYZKit' do
    project 'YYZKit/YYZKit'
    commonPods
    
    target 'YYZKitTests' do
        inherit! :search_paths
    end
end

# Same Podfile, multiple Xcodeprojects
# 主体工程需要引入的第三方库
target 'YYZMainProj' do
    project 'YYZMainProj/YYZMainProj'
    commonPods
    pod 'SDWebImage', '~> 5.3.3'
    pod 'AFNetworking', '~> 3.2.1'

    target 'YYZMainProjTests' do
        inherit! :search_paths
    end
end