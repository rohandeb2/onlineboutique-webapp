# --- Stage 1: Build ---
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS builder
WORKDIR /app

# Senior Tip: Cache dependencies separately
COPY src/cartservice.csproj .
RUN dotnet restore -r linux-musl-x64

COPY . .

# --- Stage 2: Publish ---
# We create a self-contained binary for the specific Alpine architecture
RUN dotnet publish -c Release \
    -o /out \
    --no-restore \
    --runtime linux-musl-x64 \
    --self-contained true \
    -p:PublishSingleFile=true \
    -p:PublishTrimmed=true \
    -p:TrimMode=full

# --- Stage 3: Hardened Runtime ---
FROM mcr.microsoft.com/dotnet/runtime-deps:8.0-alpine
WORKDIR /app

# Copy only the final standalone binary and config
COPY --from=builder /out/cartservice .
COPY --from=builder /out/appsettings.json .

# Security: Set executable permissions and use non-root UID
RUN chmod +x ./cartservice
USER 1000

# Industry Standard: Use ENV for port flexibility
ENV ASPNETCORE_URLS=http://*:7070 \
    LISTEN_ADDR=0.0.0.0 \
    PORT=7070

EXPOSE 7070

ENTRYPOINT ["./cartservice"]
