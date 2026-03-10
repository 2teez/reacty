#!/usr/bin/env bash
# author:      omitida
# date:        09/03/26
# description: Create react components, html templates, and css stylesheets
#

function help() {
    echo "Usage: makerjs.sh <options> <filename>"
    echo "Options:"
    echo "  -h, --help      Display this help message"
    echo "  -p, --project   Create a new react project"
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
        --delete) set -- "$@" "-d" ;;
        --project) set -- "$@" "-p" ;;
        --template) set -- "$@" "-t" ;;
        --style) set -- "$@" "-s" ;;
        *) set -- "$@" "${arg}" ;;
    esac
done

options="hc:d:t:s:p:"
while getopts "${options}" opt; do
    case "${opt}" in
        h) help ;;
        c) echo "Creating component: ${OPTARG}" ;;
        d) echo "Deleting component: ${OPTARG}"
        if ! [[ -e "${OPTARG}" ]]; then
            echo "${OPTARG} not found"
            exit 0
        fi
           while true; do
               read -p "Are you sure you want to delete ${OPTARG}? (y/n) " yn
               case $yn in
                   [Yy]* ) break;;
                   [Nn]* ) exit 0;;
                   * ) echo "Please answer yes or no.";;
               esac
           done
           rm -rf ${OPTARG}
           exit 0
           ;;
        t) echo "Creating template: ${OPTARG}" ;;
        s) echo "Creating style: ${OPTARG}" ;;
        p) echo "Creating project: ${OPTARG}"
           npm init react-app ${OPTARG} --template typescript
           cd ${OPTARG}
           npm start
           exit 0
            ;;
        *)
            echo "Invalid option: ${OPTARG}"
            help ;;
    esac
done
