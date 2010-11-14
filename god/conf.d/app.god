celeryd_list = Array.new

# Find and watch any celeryd processes for this app, assuming they have an
# init.d script at /etc/init.d/celeryd-APPNAME_ENVIRONMENT.
Dir["/etc/init.d/celeryd-app_*"].each do |file|
    next if file.end_with? ".bak"
    celeryd = Hash.new
    celeryd[:name] = "#{file}"
    celeryd[:start] = "#{file} start"
    celeryd[:stop] = "#{file} stop"
    celeryd[:restart] = "#{file} restart"
    celeryd[:pidfile] = File.join("/var/run", "#{File.basename(file)}.pid")
    celeryd_list << celeryd
end

celeryd_list.each do |celeryd|
  God.watch do |w|
    w.name = celeryd[:name]
    w.interval = 30.seconds # default      
    w.start = celeryd[:start] 
    w.stop = celeryd[:stop]
    w.restart = celeryd[:restart]
    w.start_grace = 10.seconds
    w.restart_grace = 10.seconds
    w.pid_file = celeryd[:pidfile] 
    w.behavior(:clean_pid_file)

    w.start_if do |start|
        start.condition(:process_running) do |c|
            c.interval = 5.seconds
            c.running = false
            c.notify = 'campfire-room'
        end
    end
  end
end

# Watch the actual gunicorn process
God.watch do |w|
    w.name = "app"
    w.interval = 30.seconds
    w.start = "/etc/init.d/app start"
    w.stop = "/etc/init.d/app stop"
    w.restart = "/etc/init.d/app restart"
    w.start_grace = 10.seconds
    w.restart_grace = 10.seconds
    w.pid_file = "/var/run/gunicorn/app.pid"
    w.behavior(:clean_pid_file)

    w.start_if do |start|
        start.condition(:process_running) do |c|
            c.interval = 5.seconds
            c.running = false
            c.notify = 'campfire-room'
        end
    end
end
