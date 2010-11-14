python-webapp-etc -- config files for tools to deploy Python webapps
=========================================================================

## Description

This repository is a collection of configuration files for a common Python
webapp deployment. This collection of tools is currently used in production at
[Bueda](http://www.bueda.com).

### Related Projects

[django-boilerplate](https://github.com/bueda/django-boilerplate)
[tornado-boilerplate](https://github.com/bueda/tornado-boilerplate)
[buedafab](https://github.com/bueda/buedafab)
[comrade](https://github.com/bueda/django-comrade)

## Tools & Services

### gunicorn

[Gunicorn](http://gunicorn.org/) is "a Python WSGI HTTP Server for UNIX." It's
fast, easier to use than Apache's `mod_wsgi`, and has first-class support
for frameworks like Django and Paster.

### nginx

Gunicorn doesn't handle slow clients, so the makers "strongly advise that you
use [Nginx](http://nginx.org/)" to proxy incoming requests. We also use the
nginx proxy to serve static files.

### runit

We use [runit](http://smarden.org/runit/) (that's "run-it", not "r-unit" as I
thought for many months...) to create init-style scripts for each application's
gunicorn process.

### god

We use [god](https://github.com/mojombo/god) to keep our nginx, gunicorn and
[celeryd](http://celeryproject.org/) processes running.

This also offers a workaround for a memory leak in `celeryd` when it runs in
`DEBUG` mode. If the `celeryd` process consumers over some set amount of memory
(e.g. 300MB), `god` can bounce it for you automatically.

### rsyslog

We direct Python's logging module to the syslog, and use rsyslog to split out
each application's logs into individual files. Rsyslog can also send these logs
to a central server, split by date, etc.

## Contributing

If you have improvements to this configuration:

* Fork the repository on [GitHub](https://github.com/bueda/python-webapp-etc)
* File an issue for the bug fix/feature request in GitHub
* Create a topic branch
* Push your modifications to that branch
* Send a pull request

## Authors

* [Bueda Inc.](http://www.bueda.com)
* Christopher Peplin, peplin@bueda.com, @[peplin](http://twitter.com/peplin)
