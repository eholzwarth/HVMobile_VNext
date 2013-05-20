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
end
