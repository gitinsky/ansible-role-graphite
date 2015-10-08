Eye.application 'graphite-api' do
  stdall '/var/log/eye/graphite-api-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :'graphite-api' do
    pid_file '/var/run/graphite_api.pid'
    start_command 'gunicorn -w2 graphite_api.app:app -b {{ graphite_api_bind_ip }}:{{ graphite_api_port }}'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
