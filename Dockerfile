#FROM alpine
#LABEL maintainers="drzhangg"
#LABEL description="KVM CSI Driver"
#
#RUN apk add util-linux e2fsprogs
#COPY /bin/kvm-csi-driver /kvm-csi-driver
#ENTRYPOINT ["/kvm-csi-driver"]

FROM golang:1.17.3-alpine3.13 as builder

WORKDIR /build

ENV GO111MODULE=on \
	GOPROXY=https://goproxy.cn

COPY go.mod .

COPY go.sum .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux  go build -a -o kvm-csi-driver cmd/main.go

FROM alpine:3.11 as final

WORKDIR /

COPY --from=builder /build/kvm-csi-driver /

RUN chmod +x /kvm-csi-driver

ENV TZ=Asia/Shanghai

CMD ["/kvm-csi-driver"]
