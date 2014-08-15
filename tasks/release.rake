def version
  version = ENV['VERSION'].to_s.sub(/^v/, '')
  if version.empty?
    warn("usage: VERSION=x.y.z rake release:tag")
    exit
  end
  version
end

namespace :release do

  task :check_version do
    version
  end

  task :check_clean do
    unless `git diff --shortstat 2> /dev/null | tail -n1` == ''
      warn('workspace must be clean to release')
      exit(1)
    end
  end

  task :tag do
    path = 'lib/auto_deploy_test/version.rb'
    file = File.read(path)
    file = file.gsub(/VERSION = '.+?'/, "VERSION = '#{version}'")
    File.open(path, 'w') { |f| f.write(file) }
    sh("git add lib/auto_deploy_test/version.rb")
    sh("git commit -m \"Tag release v#{version}\"")
    sh("git tag -a v#{version} -m \"See ...\"")
  end

  task :push do
    sh('git push origin')
    sh('git push origin --tags')
  end

end

desc "Releases a new version"
task :release => [
  'release:check_version',
  'release:check_clean',
  'test',
  'changelog:version',
  'release:tag',
  'release:push',
]
