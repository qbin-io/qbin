#!/bin/sh

# Stop gracefully
stop() {
    echo "Stopping $qbin_pid (qbin)"
    kill -TERM $qbin_pid 2>/dev/null
    wait $qbin_pid
    
    echo "Stopping $prism_pid (prism-server)"
    kill -TERM $prism_pid 2>/dev/null
    wait $prism_pid
}
trap "stop; exit" TERM INT

# Start prism-server
rm -f /tmp/prism-server.sock
node prism-server &
prism_pid=$!

# Start qbin
qbin "$@" &
qbin_pid=$!

# Keep running until everything stops
wait
