# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # inhibit_all_warnings!

def shared_pods
    #Network
    pod 'Moya/RxSwift'
    pod 'ObjectMapper'
    pod 'Moya-ObjectMapper/RxSwift', :git => 'https://github.com/dangthaison91/Moya-ObjectMapper', :branch => 'master'

    #Database
    pod 'RealmSwift'
    # pod 'KeychainAccess'

    #Reactive
    pod 'Action'
    pod 'RxSwift'
    pod 'RxCocoa'
    # pod 'RxViewModel'
    pod 'RxFlow'
    pod 'RxDataSources'
    pod 'RxRealm'
    pod 'RxSwiftExt'
    pod 'RxOptional'

    #UI
    # pod "ESTabBarController-swift"
    # pod 'Eureka', :git => 'https://github.com/dangthaison91/Eureka.git', :branch => 'dangthaison91-master'
    # pod 'MaterialComponents/TextFields', :inhibit_warnings => true
    pod 'FoldingCell'
    # pod 'Highlighter'

    pod 'Reusable/View'
    # pod 'M13Checkbox'
    # pod 'SnapKit'


    # Tool
    pod 'ReachabilitySwift'
    pod 'SwiftDate'
    pod 'SwiftGen'
    # pod 'SwiftLint'

#    pod "HyperioniOS/Core", :configurations => ['Debug']
#    #"Configurations => Debug" ensures it is only included in debug builds. Add any configurations you would like Hyperion to be included in.
#    pod 'HyperioniOS/AttributesInspector', :configurations => ['Debug'] # Optional plugin
#    pod 'HyperioniOS/Measurements', :configurations => ['Debug'] # Optional plugin
#    pod 'HyperioniOS/SlowAnimations', :configurations => ['Debug'] # Optional plugin

    # Crashlytics
    # pod 'Fabric'
    # pod 'Crashlytics'

  end

  target 'RxFlowDemo' do
    shared_pods
  end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.name == 'Debug'
                config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
            end
        end
    end
end
