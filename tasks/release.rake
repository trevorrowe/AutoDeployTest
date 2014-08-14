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
    sh("git add lib/auto_deploy_test/version.rb")
    sh("git commit -m \"Tag release v#{version}\"")
    sh("git tag v#{version}")
  end

  task :push do
    sh("git push origin --follow-tags")
  end

end

desc "Releases a new version"
task :release => %w(test release:tag release:push)
