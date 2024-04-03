FROM openjdk:16-jdk-alpine AS java
RUN apk add wget unzip

ENV ID=000
ENV HOST=/app/host

WORKDIR /app
RUN adduser -u 1000 --disabled-password --gecos "" appuser && chown -R appuser /app

USER appuser
RUN wget https://static.anaf.ro/static/DUKIntegrator/dist_javaInclus20200203.zip -O /app/DUKIntegrator.zip
RUN unzip /app/DUKIntegrator.zip -d /app
RUN mv /app/dist/* /app/
RUN mkdir -p $HOST
RUN rm /app/DUKIntegrator.zip

COPY ./lib/* /app/lib/

CMD java -jar ./DUKIntegrator.jar -p D$ID $HOST/D$ID.xml $HOST/D$ID.log 0 0 $HOST/file-D$ID.pdf
