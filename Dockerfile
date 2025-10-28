FROM python:3.12-alpine3.21

RUN apk add --no-cache gammu-dev tzdata

RUN apk add --no-cache --virtual .build-deps gcc musl-dev \
     && pip install python-gammu paho-mqtt \
     && apk del .build-deps gcc musl-dev

WORKDIR /app

COPY sms2mqtt.py .

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD ps aux | grep -q "[p]ython /app/sms2mqtt.py" || exit 1

ENTRYPOINT ["python", "/app/sms2mqtt.py"]
