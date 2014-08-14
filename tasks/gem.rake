namespace :gem do

  task :build do
    sh("gem build auto-deploy-test.gemspec")
  end

end
