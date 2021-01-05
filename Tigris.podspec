Pod::Spec.new do |s|
  s.name             = 'Tigris'
  s.version          = '0.1.1'
  s.summary          = 'A short description of Tigris.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Ishchemeleu/tig-test'
  s.license          = { :type => 'None', :file => 'LICENSE' }
  s.author           = { 'test@test.com' => 'test@test.com' }
  s.source           = { :git => 'https://github.com/Ishchemeleu/tig-test', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'Sources/**/*'
  s.dependency 'Realm'
  s.dependency 'RealmSwift'

end
