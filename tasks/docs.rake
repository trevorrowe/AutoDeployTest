require 'yard'

namespace :docs do

  task :clobber do
    rm_rf ".yardoc"
    rm_rf "api-docs"
    rm_rf "api-docs.tgz"
  end

  desc "Generates api-docs.tgz"
  task :zip do
    sh "tar czvf api-docs.tgz api-docs/"
  end

end

desc "Generates the API documentation."
YARD::Rake::YardocTask.new(:'docs:build')

task :docs => %w(docs:clobber docs:build docs:zip)
