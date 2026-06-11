FROM golang:1.21.3-alpine AS builder

RUN apk add --no-cache ca-certificates git build-base

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .

ARG SKAFFOLD_GO_GCFLAGS

RUN CGO_ENABLED=0 go build -gcflags="${SKAFFOLD_GO_GCFLAGS}" -ldflags="-s -w" -o /frontend .

FROM gcr.io/distroless/static-debian12:latest

WORKDIR /app

COPY --from=builder /frontend ./server
COPY --from=builder /src/templates ./templates
COPY --from=builder /src/static ./static

ENV GOTRACEBACK=single PORT=8080

USER nonroot:nonroot

EXPOSE 8080

ENTRYPOINT ["/app/server"]