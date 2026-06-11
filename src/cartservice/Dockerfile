FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS builder
WORKDIR /app

RUN apk add --no-cache libc6-compat gcompat

COPY cartservice.sln .
COPY src/cartservice.csproj src/
COPY tests/cartservice.tests.csproj tests/
RUN dotnet restore cartservice.sln -r linux-musl-x64

COPY . .

RUN dotnet publish src/cartservice.csproj -c Release -o /out --no-restore --runtime linux-musl-x64 --self-contained true -p:PublishSingleFile=true -p:PublishTrimmed=true -p:TrimMode=full

FROM mcr.microsoft.com/dotnet/runtime-deps:8.0-alpine
WORKDIR /app

COPY --from=builder /out/cartservice .
COPY --from=builder /out/appsettings.json .

RUN chmod +x ./cartservice

USER 1000

ENV ASPNETCORE_URLS=http://*:7070 LISTEN_ADDR=0.0.0.0 PORT=7070

EXPOSE 7070

ENTRYPOINT ["./cartservice"]