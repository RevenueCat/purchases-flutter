require 'json'
require 'pathname'

def revenuecat_git_pods_config
  root = File.expand_path('..', __dir__)
  path = ENV.fetch('RC_GIT_PODS_CONFIG', File.join(root, 'build/git-pods.json'))
  unless File.file?(path)
    system('python3', File.join(__dir__, 'resolve-git-pods.py'), '--output', path, exception: true)
  end
  JSON.parse(File.read(path))
end

def revenuecat_git_pods
  config = revenuecat_git_pods_config
  native = 'https://github.com/RevenueCat/purchases-ios.git'
  phc = 'https://github.com/RevenueCat/purchases-hybrid-common.git'
  pod 'RevenueCat', git: native, tag: config.fetch('native_version')
  pod 'RevenueCatUI', git: native, tag: config.fetch('native_ui_version')
  pod 'PurchasesHybridCommon', git: phc, commit: config.fetch('phc_commit')
  pod 'PurchasesHybridCommonUI', git: phc, commit: config.fetch('phc_commit')
end

if __FILE__ == $PROGRAM_NAME
  command = ARGV.shift
  if command == 'verify'
    require 'cocoapods'
    config = revenuecat_git_pods_config
    expected = {
      'RevenueCat' => config.fetch('native_version'),
      'RevenueCatUI' => config.fetch('native_ui_version'),
      'PurchasesHybridCommon' => config.fetch('phc_version'),
      'PurchasesHybridCommonUI' => config.fetch('phc_version')
    }
    raise 'Provide at least one Podfile.lock' if ARGV.empty?
    ARGV.each do |path|
      lockfile = Pod::Lockfile.from_file(Pathname(path))
      sources = lockfile.to_hash.fetch('EXTERNAL SOURCES')
      checkouts = lockfile.to_hash.fetch('CHECKOUT OPTIONS')
      expected.each do |name, version|
        repo = name.start_with?('PurchasesHybridCommon') ? 'purchases-hybrid-common' : 'purchases-ios'
        unless sources.fetch(name).fetch(:git) == "https://github.com/RevenueCat/#{repo}.git"
          raise "#{name} must be sourced from Git"
        end
        raise "#{name} version mismatch" unless lockfile.version(name) == Pod::Version.new(version)
        if repo == 'purchases-hybrid-common'
          raise "#{name} commit mismatch" unless checkouts.fetch(name).fetch(:commit) == config.fetch('phc_commit')
        else
          raise "#{name} tag mismatch" unless sources.fetch(name).fetch(:tag) == version
        end
      end
      puts "Verified the four Git-sourced pods in #{path}"
    end
  elsif command == 'bundles'
    app = ARGV.fetch(0)
    %w[PurchasesHybridCommon.bundle RevenueCat_RevenueCatUI.bundle].each do |bundle|
      paths = Dir.glob(File.join(app, '**', bundle))
      raise "Missing packaged resource bundle #{bundle}" unless paths.any? { |path| File.directory?(path) && !File.symlink?(path) }
    end
    puts "Verified core/UI resources in #{app}"
  else
    raise 'Usage: ruby scripts/git-pods.rb verify Podfile.lock [...] | bundles App.app'
  end
end
