
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
RUN touch /test4.yo
EXPOSE 3000/tcp


CMD ["/home/cmd.bash"]