Pod::Spec.new do |spec|
  spec.name         = 'NewsParser'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'GPL' }
  spec.homepage     = 'https://github.com/DeniZDobynda/NewsParser'
  spec.authors      = { 'Denis Dobynda' => 'denisdarm@gmail.com' }
  spec.summary      = 'News parser for https://newsapi.org'
  spec.source       = { :git => 'https://github.com/DeniZDobynda/NewsParser.git', :tag => 'v0.1.0' }
  spec.source_files = 'NewsParser.{h,m}'
  spec.ios.deployment_target  = '9.0'
  spec.framework    = 'Foundation'
  spec.dependency 'API'
end