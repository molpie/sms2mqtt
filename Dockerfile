FROM python:3.11-alpine3.18

RUN apk add --no-cache gammu-dev tzdata

RUN apk add --no-cache --virtual .build-deps gcc musl-dev \
     && pip install python-gammu paho-mqtt \
     && apk del .build-deps gcc musl-dev

WORKDIR /app

COPY sms2mqtt.py .

ENTRYPOINT ["python", "/app/sms2mqtt.py"]
