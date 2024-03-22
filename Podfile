platform :ios, '12.0'

target 'CalculatorFYL' do
pod 'Masonry'
pod 'AFNetworking'
pod 'MJRefresh'
pod 'SDWebImage'
pod 'YYModel'
pod 'LKDBHelper'
pod 'TZImagePickerController/Basic' # No location code
pod 'LSSafeProtector'
pod 'SVProgressHUD'
pod 'MBProgressHUD'
pod 'JKCategories'
#pod 'TTConsole'# 开发调试工具收集崩溃等
post_install do |installer|
        installer.generated_projects.each do |project|
              project.targets.each do |target|
                  target.build_configurations.each do |config|
                      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
                   end
              end
       end
    end

end
