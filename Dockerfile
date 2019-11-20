FROM golang:1.13-alpine

RUN apk add --no-cache git bzr make ca-certificates

ENV \
  GO111MODULE=on \
  CGO_ENABLED=0 \
  GOOS=linux \
  GOARCH=amd64

WORKDIR /go/src/github.com/egeneralov/glauth
ADD go.mod go.sum /go/src/github.com/egeneralov/glauth/
RUN go mod download

ADD . .

RUN \
  go get -v -u github.com/jteeuwen/go-bindata/... && \
  /go/bin/go-bindata -pkg=main assets . && \
  go build -v -installsuffix cgo -ldflags="-w -s" -o /go/bin/glauth .


FROM alpine:3.10

RUN apk add --no-cache openldap-clients ca-certificates
COPY --from=0 /go/bin /go/bin
USER nobody
EXPOSE 389 636 5555
CMD /go/bin/glauth
