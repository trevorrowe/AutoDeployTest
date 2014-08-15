def version
  version = ENV['VERSION'].to_s.sub(/^v/, '')
  if version.empty?
    warn("usage: VERSION=x.y.z rake release:tag")
    exit
  end
  version
end

namespace :release do

  task :require_version do
    version
  end

  task :changelog do
    changelog = File.open('CHANGELOG.md', 'r', encoding: 'UTF-8') { |f| f.read }
    changelog = changelog.lines
    changelog = changelog[0..4] + [nil, nil, nil] + changelog[5..-1]
    changelog[5] = "v#{version} (#{Time.now.strftime('%Y-%m-%d')})\n"
    changelog[6] = '-' * (changelog[3].chars.count - 1) + "\n"
    changelog[7] = "\n"
    changelog = changelog.join
    File.open('CHANGELOG.md', 'w', encoding: 'UTF-8') { |f| f.write(changelog) }
    sh("git add CHANGELOG.md")
  end

  task :tag do
    path = 'lib/auto_deploy_test/version.rb'
    file = File.read(path)
    file = file.gsub(/VERSION = '.+?'/, "VERSION = '#{version}'")
    File.open(path, 'w') { |f| f.write(file) }
    sh("git add lib/auto_deploy_test/version.rb")
    sh("git commit -m \"Tag release v#{version}\"")
    sh("git tag v#{version}")
  end

  task :push do
    sh('git push origin')
    sh('git push origin --tags')
  end

end

desc "Releases a new version"
task :release => %w(release:require_version test release:tag release:push)
