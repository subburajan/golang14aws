FROM golang:1.14-alpine

# Install necessary tools
RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache && \
    pip3 install --upgrade awscli && \
    apk add --update bash && rm -rf /var/cache/apk/*

# Adding edge repo so we can add glide
RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && apk update
RUN apk add --upgrade apk-tools@edge
RUN apk add git
RUN apk add openssh
RUN go get -u github.com/golang/dep/cmd/dep
RUN apk add --no-cache glide@edge git g++ make
