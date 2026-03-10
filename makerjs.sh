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
    echo "  -f, --standard  <standard-name>   Create a new react standalone file"
    echo "  -p, --project   <project name>    Create a new react project"
    echo "  -t, --template  <template-name>   Create a new html template"
    echo "  -s, --style <style-name>          Create a new css stylesheet"
    echo "  -r, --run       <directory>       Run the react project"
    exit 0
}

function check_file_exists() {
    if [[ -e "${filename}" ]]; then
        echo "File already exists: ${filename}! Can't overwrite."
        exit 1
    fi
}

function create_jsx_file() {
    local file="${1}"
    check_file_exists "${file}"

    local filename="${file%.*}"
    echo " const Greet = ({ name }) => <hl>Hello {name}!</hl>;
    const rootElement = document.getElementById('root');
    const root = ReactDOM.createRoot(rootElement);
    root.render(<Greet name=\"Reader\" />);" > "${filename}.jsx"
    echo "Created file: ${filename}"
}

function create_html_file() {
    local file="${1}"
    check_file_exists "${file}"

    local filename="${file%.*}"
    echo "
    <!DOCTYPE html>
    <html lang=\"en\">
        <head>
            <meta charset=\”UTF-8\">
            <title>Hello Reactjs!</title>
            <script src=\"https://unpkg.com/react@18/umd/react.development.js\" crossorigin></script>
            <script src=\"https://unpkg.com/react-dom@18/umd/react-dom.development.js\" crossorigin></script>
            <script src=\"https://unpkg.com/babel-standalone@6/babel.min.js\"></script>
            <script src=\"${filename}.jsx\" type=\"text/babel\"></script>
        </head>
        <body>
            <div id=\"root\"></div>
        </body>
    </html>
    " > "${filename}.html"
    echo "Created file: ${filename}"
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
        --file) set -- "$@" "-f" ;;
        --project) set -- "$@" "-p" ;;
        --template) set -- "$@" "-t" ;;
        --style) set -- "$@" "-s" ;;
        --run) set -- "$@" "-r" ;;
        *) set -- "$@" "${arg}" ;;
    esac
done

options="hc:d:f:t:s:p:r:"
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
        f)
            filename="${OPTARG}"
            mkdir "${filename}" && cd "${filename}"
            mkdir src public
            create_html_file "index.html"
            mv index.html public/
            create_jsx_file "index.jsx"
            mv index.jsx src/
            touch src/App.jsx
            # install local http-server
            npm init -y > /dev/null
            npm install http-server
            # start the local server
            node_modules/.bin/http-server
            exit 0
            ;;
        t) echo "Creating template: ${OPTARG}" ;;
        s) echo "Creating style: ${OPTARG}" ;;
        r) echo "Running project: ${OPTARG}"
           cd ${OPTARG}
           node_modules/.bin/http-server
           exit 0
           ;;
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
