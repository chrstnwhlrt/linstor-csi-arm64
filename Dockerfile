FROM arm64v8/golang:1 as builder
COPY ./linstor-csi /usr/local/go/linstor-csi
RUN cd /usr/local/go/linstor-csi && ARCH=arm64 make -f container.mk staticrelease && mv ./linstor-csi-linux-arm64 /

FROM arm64v8/debian:buster-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
      xfsprogs e2fsprogs \
      && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY --from=builder /linstor-csi-linux-arm64 /linstor-csi
ENTRYPOINT ["/linstor-csi"]
