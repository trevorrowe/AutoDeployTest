root = File.dirname(__FILE__)

$:.unshift(File.join(root, "lib"))

Dir[File.join(root, 'tasks', '**', '*.rake')].each do |task_file|
  load task_file
end

task :default => %w(test)

task :build => %w(test gem:build docs)
