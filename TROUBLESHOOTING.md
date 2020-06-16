# Some troubleshooting steps that may be useful

This might not mean anything to people other than CoCalc developers.  In any case, you can try restarting some services, and gathering log files, etc., and it could be helpful.

## Projects

Each project has several logfiles.  

- The overall project server has a logfile located in `~/.smc/local_hub/local_hub.log`.

- The Sage server has a logfile in `~/.smc/sage_server/sage_server.log`, which may be relevant is you are using Sage worksheets.

- If you use Jupyter classic mode, then there are log files in `~/.smc/jupyter`

## The compute server

This is a node.js process that is responsible for starting and stopping projects, and creating and deleting the corresponding Linux accounts.   To find the process get a root shell in the Docker container, then use pgrep:
```
sudo docker exec -it cocalc bash  # or whatever you named it
root@367b9eb05898:/# pgrep -af compute.js
121 node run/compute.js --host=localhost --single start
```

You can see what the compute server is up to by watching `/var/log/compute.err`:

```
root@367b9eb05898:/# tail -f /var/log/compute.err
2020-06-16T04:00:16.130Z - debug: update_state: got 0 projects that are '....ing'
2020-06-16T04:02:16.181Z - debug: kill_idle_projects: query database for all projects
2020-06-16T04:02:16.181Z - debug: sql: query='SELECT project_id,state_time,mintime FROM projects  WHERE state=?', vals=["running"]
...
```

If you kill the compute server it will _not_ automatically restart.  You can start it manually as follows:
```
cd /cocalc/src; . smc-env; compute --host=localhost --single start 1>>/var/log/compute.log 2>>/var/log/compute.err &
```

Killing it, then starting it, may be a useful step for troubleshooting.

Another interesting fact is that the computer server accomplishes all of its tasks by running a script called `smc-compute`.  That script just calls what is currently
```
/usr/local/lib/python2.7/dist-packages/smc_pyutil/smc_compute.py
```
though that may move to python3.x in the near future.  Modifying this can be useful in case you want to change Linux groups of projects, etc.

## The hub

This is a node.js process that every web browser connects to. It communicates with the database, asks the compute server to start and stop projects (etc), and proxies traffic between browsers and projects.

You can find the process via `pgrep -af hub.js`:
```
root@367b9eb05898:/# pgrep -af hub.js
175 /usr/bin/node /cocalc/src/smc-hub/node_modules/start-stop-daemon/monitor.js /cocalc/src/smc-hub/run/hub.js
188 /usr/bin/node /cocalc/src/smc-hub/run/hub.js run --host=localhost --port 5000 --proxy_port 5001 --share_port 5002 --share_path=/projects/[project_id] --update --single --logfile /var/log/hub.log --pidfile /run/hub.pid
```

If you kill the larger-pid process, then the hub will automatically restart:
```
root@367b9eb05898:/# kill 188
root@367b9eb05898:/# pgrep -af hub.js
175 /usr/bin/node /cocalc/src/smc-hub/node_modules/start-stop-daemon/monitor.js /cocalc/src/smc-hub/run/hub.js
1971 /usr/bin/node /cocalc/src/smc-hub/run/hub.js run --host=localhost --port 5000 --proxy_port 5001 --share_port 5002 --share_path=/projects/[project_id] --update --single --logfile /var/log/hub.log --pidfile /run/hub.pid
```

Doing this may be a useful test for troubleshooting purposes.

## Other standard services

There is also an haproxy server, an nginx server, and a PostgreSQL database running in cocalc-docker.  They are setup using completely standard system-wide scripts and configuration and log to the usual places.

