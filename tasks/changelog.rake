namespace :changelog do

  desc "Adds a changelog entry."
  task :add do
    entry = `lorem-ipsum --words 20`
    entry = entry.gsub(/(.{1,76})(?: +|$)\n?|(.{76})/, "  \\1\\2\n")
    entry = "*" + entry[1..-1] + "\n"
    changelog = File.open('CHANGELOG.md', 'r') { |f| f.read }.lines
    changelog = changelog[0..4] + [entry] + changelog[5..-1]
    changelog = changelog.join
    File.open('CHANGELOG.md', 'w', encoding: 'UTF-8') { |f| f.write(changelog) }
  end

  task :version do
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

  task :latest do
    changelog = File.open('CHANGELOG.md', 'r', encoding: 'UTF-8') { |f| f.read }
    lines = []
    changelog.lines[8..-1].each do |line|
      if line.match(/^v\d/)
        break
      else
        lines << line
      end
    end
    puts lines[0..-2].join
  end

end
