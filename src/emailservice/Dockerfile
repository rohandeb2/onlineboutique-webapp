FROM python:3.10.8-slim AS builder

RUN apt-get -qq update && apt-get install -y --no-install-recommends wget g++ && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

FROM python:3.10.8-slim

ENV PYTHONUNBUFFERED=1 PYTHONDONTWRITEBYTECODE=1 ENABLE_PROFILER=1

WORKDIR /app

COPY --from=builder /install /usr/local

COPY . .

RUN addgroup --system --gid 1001 appuser && adduser --system --uid 1001 --gid 1001 appuser

USER 1001

EXPOSE 8080

ENTRYPOINT ["python", "email_server.py"]