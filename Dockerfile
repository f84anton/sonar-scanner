FROM openjdk:8-jre-alpine

ENV SONAR_SCANNER_VERSION 3.0.3.778

RUN apk add --no-cache wget tzdata && \
	mkdir -p -m 777 /sonar-scanner && \
	wget -q https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION.zip -O /root/sonar-scanner.zip && \
	unzip /root/sonar-scanner.zip -d /sonar-scanner/ && \
	rm -f /root/sonar-scanner.zip && \
	apk del wget
	
ENV SONAR_SCANNER_HOME=/sonar-scanner/sonar-scanner-$SONAR_SCANNER_VERSION
ENV PATH $PATH:/sonar-scanner/sonar-scanner-$SONAR_SCANNER_VERSION/bin

WORKDIR /app
ENTRYPOINT [ "sonar-scanner" ]

RUN ln -fs /usr/share/zoneinfo/${TIMEZONE:-Europe/Moscow} /etc/localtime && echo "${TIMEZONE:-Europe/Moscow}" > /etc/timezone
