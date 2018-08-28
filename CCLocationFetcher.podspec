
Pod::Spec.new do |s|
  s.name         = "CCLocationFetcher"
  s.version      = "1.0.0"
  s.summary      = "A tool that get location info easily."
  s.description  = "You can use CCLocationFetcher to get location info with one line of code."
  s.homepage     = "https://github.com/RachalZhou/CCLocationFetcher"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "RachalZhou" => "1048255049@qq.com" }
  s.source       = { :git => "https://github.com/RachalZhou/CCLocationFetcher.git", :tag => "#{s.version}" }
  s.source_files  = "CCLocationFetcher/*"
  s.requires_arc = true
  # s.dependency "JSONKit", "~> 1.4"

end
