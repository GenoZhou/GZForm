Pod::Spec.new do |s|
  s.name          = "GZForm"
  s.module_name   = "GZForm"
  s.version       = "1.0.0"
  s.summary       = "A specialized stack view controller to build a fully-featured form. In Swift3."
#   s.description      = <<-DESC
# 			DESC
  s.homepage      = "https://github.com/genozhou/GZForm"
  s.license       = "MIT"
  s.author        = { "Hanxuan Zhou (Geno)" => "genozhou@gmail.com" }
  s.platform      = :ios, "9.0"
  s.source        = { :git => "https://github.com/genozhou/GZForm.git", :tag => s.version.to_s }
  s.source_files  = "GZForm/**"
  s.frameworks    = "UIKit"
end
