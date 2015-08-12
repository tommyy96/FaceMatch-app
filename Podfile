# Uncomment this line to define a global platform for your project
platform :ios, '8.0'

post_install do | installer |
    require 'fileutils'
    FileUtils.cp_r('Pods/Target Support Files/Pods-Recall/Pods-Recall-acknowledgements.plist', 'Settings.bundle/Acknowledgements.plist', :remove_destination => true)
end

use_frameworks!

target 'Recall' do

	pod 'Realm'
	pod 'RealmSwift'
	pod 'TPKeyboardAvoiding'
	pod 'Mixpanel'
end

target 'RecallTests' do

end

