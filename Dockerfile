FROM alpine:latest 
MAINTAINER amit@silverpush.co 
USER root WORKDIR /app 
COPY ./app /app 
EXPOSE 5000
RUN apk update R
UN apk upgrade 
RUN apk add python3 
RUN apk add py3-pip 
RUN pip3 install bottle 
ENTRYPOINT [ "/usr/bin/python3", "app.py" ]
