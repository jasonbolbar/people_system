# Public: Used to kill all the Resque processes
#
#Examples
#
# Resque::Worker::Killer.stop_workers
# #=> nil
class Resque::Worker::Killer

  #Public Kill all opened Resque processes
  #
  #Examples
  #
  # stop_workers
  # #=> nil
  #
  #Returns NilClass
  def self.stop_workers
    pids = extract_pids
    # In linux the current task may be added
    pids.reject! { |pid| %W(#{Process.ppid} #{Process.pid}).include? pid }
    pids.any? ? kill_pids(pids) : puts('No workers to kill')
  end

  private

  #Internal Identify if process is already running
  #
  #pid - id of process
  #
  #Examples
  #
  # process_exist?(23342)
  # #=> 23342
  #
  # process_exist?(555555)
  # #=> nil
  #
  #Returns id of process if it is already running
  def self.process_exist?(pid)
    begin
      Process.getpgid(pid.to_i)
    rescue Errno::ESRCH
      nil
    end
  end

  #Internal Get the ids for running Resque processes
  #
  #Examples
  #
  # extract_pids
  # #=> [23433.12344,12342]
  #
  # extract_pids
  # #=> []
  #
  #Returns Array with id processes
  def self.extract_pids
    pids = `ps -A -o pid,command | grep "[r]esque" | grep -v rake`
    puts pids
    pids.split("\n").map { |line| line.split(' ').first }.uniq
  end

  #Internal Kill a list of processes from a list of pids
  #
  #pids - list of process ids
  #kill_type - type of kill (default: 's')
  #
  #Examples
  #
  # kill_pids([23242.12423,16334])
  # #=> nil
  #
  # kill_pids([23242.12423,16334], '9')
  # #=> nil
  #
  #Returns NilClass
  def self.kill_pids(pids, kill_type = 's')
    sys_cmd = "kill -#{kill_type} QUIT #{pids.join(' ')}"
    puts "Running syscmd: #{sys_cmd}"
    system(sys_cmd)
    ensure_pids_were_killed(pids) unless kill_type == '9'
  end

  #Internal Verify if all the processes were killed
  #
  #pids - list of process ids
  #
  #Examples
  #
  # ensure_pids_were_killed([23242.12423,16334])
  # #=> nil
  #
  #Returns NilClass
  def self.ensure_pids_were_killed(pids)
    puts 'Waiting 60 seconds to check status'
    sleep 60
    stuck_pids = pids.select { |pid| process_exist?(pid) }
    stuck_pids.any? ? kill_pids(stuck_pids, '9') : puts('No stuck workers to kill')
  end

end