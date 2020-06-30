platform :ios, "13.0"
use_frameworks!
inhibit_all_warnings!

target 'twentyfour' do
  pod 'MessageKit'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
  pod 'lottie-ios'
  pod 'SwiftUIPager'
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          if target.name == 'MessageKit'
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '5.0'
              end
          end
      end
  end
end
