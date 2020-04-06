# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'PersonalFinancialHealth' do
  pod 'lottie-ios'
  pod 'AwesomeStackView', :git => 'https://github.com/Hugo-Coutinho/AwesomeStackView.git'
  target 'PersonalFinancialHealthTests' do
    inherit! :search_paths
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'PersonalFinancialHealth'
      target.build_configurations.each do |config|
        config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
        if config.name == 'Debug'
          config.build_settings['OTHER_SWIFT_FLAGS'] = '-DDEBUG'
          else
          config.build_settings['OTHER_SWIFT_FLAGS'] = ''
        end
      end
    end
  end
end
