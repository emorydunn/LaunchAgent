Pod::Spec.new do |spec|
  spec.name         = "LaunchAgent"
  spec.version      = "0.2.3"
  spec.summary      = "Programatically create and maintain launchd agents and daemons without manually building Property Lists. "
  spec.homepage     = "https://github.com/emorydunn/LaunchAgent"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author       = "Emory Dunn"
  spec.source       = { :git => "https://github.com/emorydunn/LaunchAgent.git", :tag => "#{spec.version}" }
  spec.platform     = :macos, '10.9'

  spec.source_files  = "Sources/**/*.swift"

  spec.swift_version = '4.0'
end
