God.watch do |w|
    w.name = "nginx"
    w.interval = 30.seconds # default
    w.start = "/etc/init.d/nginx start"
    w.stop = "/etc/init.d/nginx stop"
    w.restart = "/etc/init.d/nginx restart"
    w.start_grace = 10.seconds
    w.restart_grace = 10.seconds
    w.pid_file = "/var/run/nginx.pid"
    w.behavior(:clean_pid_file)

    w.start_if do |start|
      start.condition(:process_running) do |c|
          c.interval = 5.seconds
          c.running = false
          c.notify = 'campfire-room'
      end
    end
end
