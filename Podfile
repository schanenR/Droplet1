

platform :ios, '14.4'


post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
  end
 end
end

target 'Droplet1' do
  use_frameworks!
  pod 'GoogleMaps'
  # add the Firebase pod for Google Analytics
  pod 'Firebase/Analytics'
  # add pods for any other desired Firebase products
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  # https://firebase.google.com/docs/ios/setup#available-pods
end
