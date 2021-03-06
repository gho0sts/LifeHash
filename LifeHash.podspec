Pod::Spec.new do |s|
    s.name             = 'LifeHash'
    s.version          = '1.0.0'
    s.summary          = 'A beautiful method of hash visualization based on Conway’s Game of Life.'

    s.description      = <<-DESC
    A method of hash visualization based on Conway’s Game of Life that creates beautiful icons that are deterministic, yet distinct and unique given the input data.
    DESC

    s.homepage         = 'https://github.com/wolfmcnally/LifeHash'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Wolf McNally' => 'wolf@wolfmcnally.com' }
    s.source           = { :git => 'https://github.com/wolfmcnally/LifeHash.git', :tag => s.version.to_s }

    s.pod_target_xcconfig = {
        'SWIFT_OPTIMIZATION_LEVEL' => '-O',
        'SWIFT_COMPILATION_MODE' => 'wholemodule'
    }

    s.source_files = 'Sources/LifeHash/**/*'

    s.swift_version = '5.0'

    s.ios.deployment_target = '9.3'
    s.macos.deployment_target = '10.13'
    s.tvos.deployment_target = '11.0'

    s.module_name = 'LifeHash'

    s.dependency 'WolfCore'
    s.dependency 'WolfGraphics'
end
