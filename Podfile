
platform :ios, '12.0'

target 'FilmSearcher' do

  pod 'Swinject'
  pod 'SnapKit', '~> 5.6.0'
  pod 'ReSwift'
  pod 'ReactiveKit'
  pod "SwinjectAutoregistration"
  pod "Kingfisher"
  pod 'SwiftGen', '~> 6.0'

end

target 'ServiceModule' do

  pod 'ReactiveKit'
  pod 'Swinject'
  pod 'Alamofire'

end

post_install do |installer|
  # This removes the warning about swift conversion, hopefuly forever!
  installer.pods_project.root_object.attributes['LastSwiftMigration'] = 9999
  installer.pods_project.root_object.attributes['LastSwiftUpdateCheck'] = 9999
  installer.pods_project.root_object.attributes['LastUpgradeCheck'] = 9999
  installer.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
      end
    end
  end
  installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
