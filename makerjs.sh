#!/usr/bin/env bash
# author:      omitida
# date:        09/03/26
# description: Create react components, html templates, and css stylesheets
#

function help() {
    echo "Usage: makerjs.sh <options> <filename>"
    echo "Options:"
    echo "  -h, --help      Display this help message"
    echo "  -c, --component <component-name>  Create a new react component"
    echo "  -t, --template <template-name>    Create a new html template"
    echo "  -s, --style <style-name>          Create a new css stylesheet"
    exit 0
}

if [[ "$#" -ne 2 ]]; then
    help
fi

for arg in "$@"; do
    shift
    case "${arg}" in
        --help) set -- "$@" "-h" ;;
        --component) set -- "$@" "-c" ;;
        --template) set -- "$@" "-t" ;;
        --style) set -- "$@" "-s" ;;
        *) set -- "$@" "${arg}" ;;
    esac
done

options="hc:t:s:"
while getopts "${options}" opt; do
    case "${opt}" in
        h) help ;;
        c) echo "Creating component: ${OPTARG}" ;;
        t) echo "Creating template: ${OPTARG}" ;;
        s) echo "Creating style: ${OPTARG}" ;;
    esac
done
