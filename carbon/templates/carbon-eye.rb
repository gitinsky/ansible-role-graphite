Eye.application 'carbon' do
  working_dir '/opt/graphite'
  stdall '/var/log/eye/carbon-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes
  env 'GRAPHITE_ROOT' => '/opt/graphite'
  env 'PYTHONPATH' => '/usr/local/lib/python2.7/dist-packages/opt/graphite/lib'

  process :carbon do
    pid_file '/var/run/carbon-eye.pid'
    start_command 'carbon-cache.py --config /opt/graphite/conf/carbon.conf --debug start'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
