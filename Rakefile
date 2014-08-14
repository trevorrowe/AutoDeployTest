namespace :release do

  task :tag do
    version = ENV['VERSION'].to_s.sub(/^v/, '')
    if version.empty?
      warn("usage: VERSION=x.y.z rake release:tag")
      exit
    end
    path = 'lib/auto_deploy_test/version.rb'
    file = File.read(path)
    file = file.gsub(/VERSION = '.+?'/, "VERSION = '#{version}'")
    File.open(path, 'w') { |f| f.write(file) }
  end

end

task :release => [:tag]
