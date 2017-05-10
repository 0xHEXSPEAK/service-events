# Start from an Alpine  image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.

#  ----------------------
# |     Build stage     |
# ----------------------
FROM golang:1.8.1-alpine AS build-env

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/0xHEXSPEAK/service-events

# Build the outyet command inside the container.
RUN cd /go/src/github.com/0xHEXSPEAK/service-events && go build -o app

#  -----------------------
# |     Release stage    |
# -----------------------
FROM alpine:3.5

WORKDIR /service-events

# Copy the files from build-stage to the container's workspace.
COPY --from=build-env /go/src/github.com/0xHEXSPEAK/service-events/app /service-events/

# Run the outyet command by default when the container starts.
ENTRYPOINT ./app

# Document that the service listens on port 8118.
EXPOSE 8118