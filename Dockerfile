FROM alpine

ENV GOPATH=/data/go
COPY backend /data/go/src/github.com/qbin-io/backend
COPY frontend /data/frontend
COPY eff_large_wordlist.txt /data/

RUN apk add --no-cache go git musl-dev libstdc++ libc6-compat &&\
    go get github.com/qbin-io/backend/cmd/qbin &&\
    apk del --no-cache go git musl-dev &&\
    mv /data/go/bin/qbin /data/qbin && rm -r /data/go

WORKDIR "/data"
EXPOSE 80 90
CMD ["/data/qbin", "--http", ":80", "-tcp", ":90"]
