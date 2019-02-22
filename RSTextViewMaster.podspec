#
#  Be sure to run `pod spec lint RSTextViewMaster podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "RSTextViewMaster"
  s.version      = "1.0.0"
  s.summary      = "RSTextViewMaster"
  s.description  = <<-DESC
                   Easy custom placeholder and growing (iMessage-like) UITextView with customisation 
DESC
  s.homepage     = "https://github.com/iPhoNewsRO/RSTextViewMaster"
  s.screenshots  = "https://github.com/iPhoNewsRO/RSTextViewMaster/blob/master/intro.gif"
  s.license      = { :type => "GNU", :file => "LICENSE.md" }
  s.author       = { "Radu Ursache" => "radu_u@me.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/iPhoNewsRO/RSTextViewMaster.git", :tag => "#{s.version}" }
  s.source_files  = "RSTextViewMaster.swift"
  
  s.framework  = "UIKit"

  s.requires_arc = true

end
