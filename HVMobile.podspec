Pod::Spec.new do |s|
  s.name     = 'HVMobile'
  s.version  = '2.0.0'
  s.summary  = 'HealthVault iOS SDK'
  s.homepage = 'https://github.com/microsoft-hsg/HVMobile_VNext/'
  # not clear what email to use for Microsoft HSG
  s.author   = { 'Microsoft Health Solutions Group' => 'eholzwarth@littlegreensoftware.com'}

  s.source   = {
    :git => 'https://github.com/microsoft-hsg/HVMobile_VNext/',
    :commit => '92c46e446f3a8061fd4db39c804c3f9db20dbfc3'
  }

  s.description = 'HealthVault iOS SDK'

  s.platform = :ios
  # s.platform = :osx # UIAutomation isn't yet on OS X

s.source_files = 'HVLib', 'HVLib/**/*', '*.xc*'

  # A list of resources included with the Pod. These are copied into the
  # target bundle with a build phase script.
  #
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # A list of paths to preserve after installing the Pod.
  # CocoaPods cleans by default any file that is not used.
  # Please don't include documentation, example, and test files.
  #
s.preserve_paths = "HVLib"


end
