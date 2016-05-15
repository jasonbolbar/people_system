# Public: Used to initialize a worker with specific queue and index
#
# Examples
#
# Resque::Worker::Creator.run_worker('*',4)
# #=> #<Process::Waiter:0x00000004fda3f0 run>
class Resque::Worker::Creator

  #Public default options for worker creation
  OPTIONS = {
      pgroup:true,
      err:[Rails.root.join('log','workers_error.log'), 'a'],
      out:[Rails.root.join('log','workers.log'), 'a'],
  }

  #Public open a new worker with specific queue and index
  #
  #queue - name of the queue that the worker will use
  #index - index of the worker
  #
  #Examples
  #
  # run_worker('*',4)
  # #=> #<Process::Waiter:0x00000004fda3f0 run>
  #
  #Returns Process::Waiter object
  def self.run_worker(queue, index = 1)
    puts "Starting worker, index: #{index} with QUEUE: #{queue}"
    ## Using Kernel.spawn and Process.detach because regular system() call would
    ## cause the processes to quit when capistrano finishes
    pid = spawn(environment_variables(queue,index), "rake resque:work", OPTIONS)
    Process.detach(pid)
  end

  private

  #Internal Defines the environment variables for a worker
  #
  #queue - name of the queue that the worker will use
  #i - index of the worker
  #
  #Examples
  #
  # environment_variables('*',4)
  # #=> {'BACKGROUND' => '1', 'PIDFILE' => '<APP_DIR>/tmp/pids/resque_worker_*_4.pid',
  #       'VERBOSE' => '1', 'QUEUE' => '*' }
  #
  #Returns Hash with options
  def self.environment_variables(queue,i)
    {
        'BACKGROUND' => '1',
        'PIDFILE' => (Rails.root + "tmp/pids/resque_worker_#{queue.to_s}_#{i}.pid").to_s,
        'VERBOSE' =>'1',
        'QUEUE' => queue.to_s
    }
  end

end