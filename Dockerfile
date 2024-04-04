FROM alpine:3.19
RUN apk add openjdk11-jre && rm -rf /var/cache/apk/*

ENV ID=000
ENV HOST=/app/host

WORKDIR /app
RUN adduser -u 1000 --disabled-password --gecos "" appuser && chown -R appuser /app

USER appuser
RUN mkdir -p $HOST
COPY ./dist/config /app/
COPY ./dist/lib /app/
COPY ./dist/*.jar /app/
# additional libraries
COPY ./lib/* /app/lib/

CMD java -version=1.6 -jar ./DUKIntegrator.jar -p D$ID $HOST/D$ID.xml $HOST/status.log 0 0 $HOST/file-D$ID.pdf
