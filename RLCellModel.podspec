#
#  Be sure to run `pod spec lint RLCellModel.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "RLCellModel"
  s.version      = "1.0.3"
  s.summary      = "Stable version"

  s.description  = "An elegant way to create a muti-functions UITableView"

  s.homepage     = "https://github.com/liang37038/RLCellModel"
  s.screenshots  = "https://ww4.sinaimg.cn/large/006tNbRwgy1feq2pkyrgsj30ku12a0ui.jpg"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.platform 	 = :ios

  s.author             = { "Richard9661" => "liang37038@gmail.com" }
  s.social_media_url   = "https://twitter.com/Richard37038"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/liang37038/RLCellModel.git", :tag => "#{s.version}" }

  s.source_files  = "Classes", "RLCellModelProject/RLCellModel/**/*.{h,m}"

  s.requires_arc = true

end
