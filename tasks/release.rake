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
    sh("git commit -m \"$(rake release:tag_message)\"")
    sh("git tag v#{version}")
  end

  task :tag_message do
    issues = `git log $(git describe --tags --abbrev=0)...HEAD -E --grep '#[0-9]+' 2>/dev/null`
    issues = issues.scan(/((?:\S+\/\S+)?#\d+)/).flatten
    msg = "Tag release v#{version}"
    msg << "\n"
    msg << "\nReferences:#{issues.uniq.sort.join(', ')}" unless issues.empty?
    msg << "\n"

    changelog = File.open('CHANGELOG.md', 'r', encoding: 'UTF-8') { |f| f.read }
    lines = []
    changelog.lines[8..-1].each do |line|
      if line.match(/^v\d/)
        break
      else
        lines << line
      end
    end
    msg << lines[0..-2].join
    puts msg
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
