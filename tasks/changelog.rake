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

end
