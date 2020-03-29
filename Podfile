# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'PersonalFinancialHealth' do
  pod 'lottie-ios'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'PersonalFinancialHealth'
      target.build_configurations.each do |config|
        if config.name == 'Debug'
          config.build_settings['OTHER_SWIFT_FLAGS'] = '-DDEBUG'
          else
          config.build_settings['OTHER_SWIFT_FLAGS'] = ''
        end
      end
    end
  end
end
