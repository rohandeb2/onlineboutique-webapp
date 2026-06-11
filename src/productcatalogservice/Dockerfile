FROM golang:1.21.3-alpine AS builder

RUN apk add --no-cache ca-certificates git build-base

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .

ARG SKAFFOLD_GO_GCFLAGS

RUN CGO_ENABLED=0 go build -gcflags="${SKAFFOLD_GO_GCFLAGS}" -ldflags="-s -w" -o /productcatalogservice .

FROM gcr.io/distroless/static-debian12:latest

WORKDIR /app

COPY --from=builder /productcatalogservice ./server
COPY --from=builder /src/products.json .

ENV GOTRACEBACK=single

USER 65532:65532

EXPOSE 3550

ENTRYPOINT ["/app/server"]