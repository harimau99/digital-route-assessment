#!/bin/bash

usage() {
    echo "Usage:"
    echo "  $0 [OPTIONS]"
    echo "Options:"
    echo "  -h      : display this help message"
    echo "  -q      : decrease verbosity level (can be repeated: -qq, -qqq)"
    echo "  -v      : increase verbosity level (can be repeated: -vv, -vvv)"
    echo "  -l FILE : redirect logging to FILE instead of STDERR"
}

while getopts "hqvl:" opt; do
    case "$opt" in
       h) usage; exit 0 ;;
       q) (( verbosity = verbosity - 1 )) ;;
       v) (( verbosity = verbosity + 1 )) ;;
       l) exec 3>>$OPTARG ;;
       *) error "Invalid options: $1"; usage; exit 1 ;;
    esac
done
shift $((OPTIND-1))
args="$@"

notify "This logging system uses the standard verbosity level mechanism to choose which messages to print. Command line arguments customize this value, as well as where logging messages should be directed (from the default of STDERR). Long messages will be split at spaces to wrap at a character limit, and wrapped lines are indented. Wrapping and indenting can be modified in the code."

inf "Inspecting argument list: $args"

if [ ! "$args" ]; then
    warn "No arguments given"
else
    for arg in $args; do
        debug "$arg"
    done
fi