require 'resque/tasks'
require 'resque/workers/creator'
require 'resque/workers/killer'

task 'resque:setup' => :environment

namespace :resque do
  desc 'Start a specific number of workers'
  task :start_workers, [:count] => :environment do |_, args|
    count = (args[:count] || 1).to_i
    count.times do |index|
      Resque::Worker::Creator.run_worker('*', index)
    end
  end

  desc 'Stop all running workers'
  task stop_workers: :environment do
    Resque::Worker::Killer.stop_workers
  end

end