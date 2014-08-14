root = File.dirname(__FILE__)

$:.unshift(File.join(root, "lib"))

Dir[File.join(root, 'tasks', '**', '*.rake')].each do |task_file|
  puts task_file
  load task_file
end

task :default => :test
