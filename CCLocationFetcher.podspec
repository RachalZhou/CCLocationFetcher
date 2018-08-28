Pod::Spec.new do |s|

    s.name = "CCLocationFetcher"
    s.version = "0.0.1"
    s.summary = "a location fetcher"
    s.description = "a class that can get location info easily"
    s.homepage = "https://github.com/RachalZhou/CCLocationFetcher"
    s.license = { :type => 'MIT', :file => 'LICENSE' } 
    s.author = { "RachalZhou" => "zrcrachal@qq.com" } 
    s.platform = :ios, "8.0"
    s.source = { :git => "https://github.com/RachalZhou/CCLocationFetcher.git", :tag => "v#{s.version}" }
    s.source_files = "CCLocationFetcher/CCLocationDemo/CCLocationFetcher/*.{h,m}"
    s.requires_arc = true

end
