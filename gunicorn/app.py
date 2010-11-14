# What address:port to bind
bind = "unix:/var/run/gunicorn/app.sock"

backlog = 2048

# How many worker processes
workers = 4

worker_class = "egg:gunicorn#gevent"

worker_connections = 30

# What the timeout for killing busy workers is, in seconds
timeout = 60

keepalive = 2

proc_name = "/etc/gunicorn/app.py"

preload_app = True

umask = "0"
