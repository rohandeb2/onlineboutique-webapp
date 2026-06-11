FROM golang:1.21.3-alpine AS builder

RUN apk add --no-cache ca-certificates git build-base

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .

ARG SKAFFOLD_GO_GCFLAGS

RUN CGO_ENABLED=0 go build -gcflags="${SKAFFOLD_GO_GCFLAGS}" -ldflags="-s -w" -o /shippingservice .

FROM gcr.io/distroless/static-debian12:latest

WORKDIR /app

COPY --from=builder /shippingservice .

ENV GOTRACEBACK=single APP_PORT=50051

USER 65532:65532

EXPOSE 50051

ENTRYPOINT ["/app/shippingservice"]