FROM openjdk:8-jre-alpine

ENV ID=000
ENV HOST=/app/host
ENV XML=$ID.xml
ENV PDF=$ID.pdf
ENV LOG=dukintegrator.log

WORKDIR /app
RUN adduser -u 1000 --disabled-password --gecos "" appuser && chown -R appuser /app

USER appuser
RUN mkdir -p $HOST && mkdir -p /app/lib && mkdir -p /app/config
COPY ./dist/config/* /app/config
COPY ./dist/lib/* /app/lib/
COPY ./dist/*.jar /app/
# additional libraries
COPY ./lib/* /app/lib/

CMD java -jar ./DUKIntegrator.jar -p D$ID $HOST/$XML $HOST/$LOG 0 0 $HOST/$PDF
