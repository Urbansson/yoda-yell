FROM rust:1.47 as builder

COPY ./ ./

RUN cargo build --release

RUN mkdir -p /build-out

RUN cp target/release/yell-bot /build-out/

# Ubuntu 18.04
FROM ubuntu:18.04

RUN apt-get update && apt-get -y install ca-certificates libssl-dev opus-tools ffmpeg && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build-out/yell-bot /
COPY /yell.mp3 /yell.mp3

CMD /yell-bot