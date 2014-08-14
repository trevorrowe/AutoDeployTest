require 'yard'

task 'docs:clobber' do
  rm_rf '.yardoc'
  rm_rf 'api-docs'
  rm_rf 'api-docs.tgz'
end

desc 'Generates the API documentation.'
YARD::Rake::YardocTask.new('docs:build')

desc 'Generates api-docs.tgz'
task 'docs:zip' do
  sh 'tar czf api-docs.tgz api-docs/'
end

task :docs => %w(docs:clobber docs:build docs:zip)
