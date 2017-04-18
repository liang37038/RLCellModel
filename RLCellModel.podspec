Pod::Spec.new do |spec|
  spec.name         = 'RLCellModel'
  spec.version      = '0.0.1'
  spec.license      = 'MIT'
  spec.summary      = 'An elegant way to create a TableView'
  spec.homepage     = 'https://github.com/liang37038/RLCellModel'
  spec.author       = 'liang37038'
  spec.source       = { :git => "https://github.com/liang37038/RLCellModel.git", :tag => "#{spec.version}" }
  spec.source_files = 'RLCellModelProject/RLCellModel/*'
  spec.platform = :ios, '8.0'
  spec.requires_arc = true
end