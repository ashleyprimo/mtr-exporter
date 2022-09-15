# # # # # # # # # # # #
# Build Enviroment    #
# # # # # # # # # # # #
FROM       golang:1.18.4-alpine3.16 AS build-env

WORKDIR    /go/src/app

COPY       . /go/src/app/

RUN        go get
RUN        CGO_ENABLED=0 go build

# # # # # # # # # # # #
# Runtime Enviroment  #
# # # # # # # # # # # #
FROM       alpine:3.16 AS rt-env

RUN        apk add -U --no-cache mtr
COPY       --from=build-env /go/src/app/mtr-exporter /usr/bin/mtr-exporter


EXPOSE     9348

ENTRYPOINT ["/usr/bin/mtr-exporter"]
