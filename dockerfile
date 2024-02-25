FROM --platform=arm64 rust:latest as builder
WORKDIR /home/backend/
COPY ./backend/ /home/backend/
RUN cargo build --release

FROM --platform=arm64 mongo:latest
COPY ./frontend/build/ /home/static_website/

COPY --from=builder /home/backend/target/release/webtest /home/server
COPY ./cmd.bash /home/cmd.bash
RUN chmod 700 /home/cmd.bash


LABEL Author="SinNguyen"
EXPOSE 3000/tcp

WORKDIR /home/
CMD ["./cmd.bash"]