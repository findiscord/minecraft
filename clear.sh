#!/bin/bash

get_file_path() {
    pid=$1
    file_path=$(readlink /proc/$pid/exe)
    echo "File Path: $file_path"
}

get_child_processes() {
    pid=$1
    child_pids=$(pgrep -P $pid)
    if [ -n "$child_pids" ]; then
        echo "Child Processes:"
        for child_pid in $child_pids; do
            get_file_path $child_pid
            get_child_processes $child_pid
        done
    else
        echo "No child processes found."
    fi
}

if [ $# -eq 1 ]; then
    if [ -n "$(pgrep -x $1)" ]; then
        target_pid=$(pgrep -x $1)
        get_file_path $target_pid
        get_child_processes $target_pid
    else
        echo "Process not found."
    fi
elif [ $# -eq 2 ] && [ "$1" == "-p" ]; then
    target_pid=$2
    if [ -d "/proc/$target_pid" ]; then
        get_file_path $target_pid
        get_child_processes $target_pid
    else
        echo "Invalid PID."
    fi
else
    echo "Usage: $0 <process_name> OR $0 -p <pid>"
fi
