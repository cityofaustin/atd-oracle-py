FROM python:3.8-slim
WORKDIR /opt/oracle

# Install requirements
RUN apt-get update && apt-get install -y libaio1 wget unzip

# Download the instant client, sqlplus & tools
RUN wget "https://download.oracle.com/otn_software/linux/instantclient/19800/instantclient-basiclite-linux.x64-19.8.0.0.0dbru.zip" \
 && unzip instantclient-basiclite-linux.x64-19.8.0.0.0dbru.zip \
 && rm instantclient-basiclite-linux.x64-19.8.0.0.0dbru.zip
RUN wget "https://download.oracle.com/otn_software/linux/instantclient/19800/instantclient-sqlplus-linux.x64-19.8.0.0.0dbru.zip" \
 && unzip instantclient-sqlplus-linux.x64-19.8.0.0.0dbru.zip \
 && rm instantclient-sqlplus-linux.x64-19.8.0.0.0dbru.zip
RUN wget "https://download.oracle.com/otn_software/linux/instantclient/19800/instantclient-tools-linux.x64-19.8.0.0.0dbru.zip" \
 && unzip instantclient-tools-linux.x64-19.8.0.0.0dbru.zip \
 && rm instantclient-tools-linux.x64-19.8.0.0.0dbru.zip
ENV LD_LIBRARY_PATH="/opt/oracle/instantclient_19_8"

# Now install cx_Oracle
RUN pip install cx_Oracle
