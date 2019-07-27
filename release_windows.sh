#!/bin/sh
# You need to:
# go get github.com/aktau/github-release
# and that will add github-release to your go path command line
echo "Installing github-release to commandline"
echo "go get github.com/aktau/github-release"
go get github.com/aktau/github-release

# You need to create a personal github token and create an environment variable like below
#export GITHUB_TOKEN=dd3b6cac1e0a426b33e2b0852df3ab85c25b2368

export GITHUB_USER=chilipeppr

export GITHUB_REPO=serial-port-json-server

echo "About to create a Github release for Serial Port JSON Server"
if [ "$1" = "" ]; then
        echo "You need to pass in the version number as the first parameter like ./release 1.87"
        exit
fi

echo ""
echo "Before creating release"
github-release info

github-release release \
    --tag v$1 \
    --name "Serial Port JSON Server" \
    --description "A server for the Internet of Things. Lets you serve up serial ports to websockets so you can write front-end apps for your IoT devices in the browser." \

echo ""
echo "After creating release"
github-release info

echo ""
echo "Uploading binaries"

# upload a file, for example the OSX/AMD64 binary of my gofinance app
github-release upload \
    --tag v$1 \
    --name "serial-port-json-server-$1_linux_amd64.tar.gz" \
    --file snapshot/serial-port-json-server-$1_linux_amd64.tar.gz
github-release upload \
    --tag v$1 \
    --name "serial-port-json-server-$1_linux_386.tar.gz" \
    --file snapshot/serial-port-json-server-$1_linux_386.tar.gz
github-release upload \
    --tag v$1 \
    --name "serial-port-json-server-$1_linux_arm.tar.gz" \
    --file snapshot/serial-port-json-server-$1_linux_arm.tar.gz
github-release upload \
    --tag v$1 \
    --name "serial-port-json-server-$1_windows_386.zip" \
    --file snapshot/serial-port-json-server-$1_windows_386.zip
github-release upload \
    --tag v$1 \
    --name "serial-port-json-server-$1_windows_amd64.zip" \
    --file snapshot/serial-port-json-server-$1_windows_amd64.zip
github-release upload \
    --tag v$1 \
    --name "serial-port-json-server-$1_darwin_amd64.zip" \
    --file snapshot/serial-port-json-server-$1_darwin_amd64.zip
    
echo ""
echo "Done"