FROM eclipse-temurin:8-jre-alpine

ENV ID=000
ENV HOST=/app/host
ENV XML_FILE=
ENV PDF_FILE=
ENV LOG_FILE=dukintegrator.log
ENV FALLBACK=

WORKDIR /app
RUN adduser -u 1000 --disabled-password --gecos "" appuser && chown -R appuser /app

USER appuser
RUN mkdir -p $HOST && mkdir -p /app/lib && mkdir -p /app/config
COPY ./dist/config/* /app/config
COPY ./dist/lib/* /app/lib/
COPY ./dist/*.jar /app/
# additional libraries
COPY ./lib/* /app/lib/

RUN echo '#!/bin/sh' > /app/entrypoint.sh && \
    echo 'FALLBACK=${XML_FILE:-${PDF_FILE:-D${ID}}}' >> /app/entrypoint.sh && \
    echo 'XML_FILE=${XML_FILE:-$FALLBACK}' >> /app/entrypoint.sh && \
    echo 'PDF_FILE=${PDF_FILE:-$FALLBACK}' >> /app/entrypoint.sh && \
    echo 'LOG_FILE=${LOG_FILE:-dukintegrator.log}' >> /app/entrypoint.sh && \
    echo 'exec java -jar ./DUKIntegrator.jar -p D$ID $HOST/$XML_FILE.xml $HOST/$LOG_FILE 0 0 $HOST/$PDF_FILE.pdf' >> /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]
