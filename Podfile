
# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!

target 'TrumpPunch' do
  	pod 'Flurry-iOS-SDK/FlurrySDK' #Analytics Pod
	pod 'Flurry-iOS-SDK/FlurryAds' #Advertising Pod (requires Analytics)
	pod 'Firebase/Core'
	pod 'Firebase/Messaging'
	pod 'Firebase/Database'
  	pod 'Firebase/AdMob'
        ## Location/HeatMap Pods:
        pod 'XModeAPI'
        pod 'DTMHeatmap'
        pod 'Firebase/Auth'
        pod 'Google/SignIn'
        pod 'FacebookLogin'
        pod 'FacebookCore'
        pod 'TwitterKit'
        pod 'Fabric'
end

target 'TrumpPunchTests' do
    
end

target 'TrumpPunchUITests' do
    
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
