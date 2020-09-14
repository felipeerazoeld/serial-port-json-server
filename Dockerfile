FROM golang:1.12-alpine
ARG release_version=1.96
ARG release_filename=serial-port-json-server-$release_version\_linux_amd64

RUN apk update && apk add wget gzip

WORKDIR /runtime
# https://github.com/chilipeppr/serial-port-json-server/releases
RUN wget https://github.com/chilipeppr/serial-port-json-server/releases/download/v$release_version/$release_filename.tar.gz
RUN gzip -d $release_filename.tar.gz
RUN tar -xvf $release_filename.tar
WORKDIR /runtime/$release_filename
RUN chmod 777 serial-port-json-server

EXPOSE 8988
EXPOSE 8989

CMD ["./serial-port-json-server", "start"]

# example usage:
# docker build -t chilipeppr-json-server .
# docker run --net=host --device=/dev/ttyS0:/dev/ttyS0 -it chilipeppr-json-server
