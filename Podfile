# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GoReceitas' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Ignore warnings
  inhibit_all_warnings!

  # Google Sign In & Database
  pod 'FirebaseAuth'
  pod 'GoogleSignIn'
  pod 'FirebaseDatabase'
  pod 'Firebase/Storage'
  pod 'FirebaseFirestore'
  pod 'Firebase/Database'
  pod 'AlamofireImage', '~> 4.1'


  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
  end
end