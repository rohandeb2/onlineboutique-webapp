FROM python:3.11.1-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix="/install" -r requirements.txt

FROM python:3.11.1-slim

ENV PYTHONUNBUFFERED=1 PYTHONDONTWRITEBYTECODE=1 GEVENT_SUPPORT=True

WORKDIR /app

COPY --from=builder /install /usr/local

COPY locustfile.py .

RUN groupadd -g 10001 appgroup && useradd -u 10001 -g appgroup appuser

USER 10001

ENTRYPOINT ["locust", "--headless"]