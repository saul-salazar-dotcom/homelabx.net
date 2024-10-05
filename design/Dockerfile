FROM penpotapp/backend:latest

USER root
COPY rootCA.pem /usr/local/share/ca-certificates/
RUN openssl x509 -outform der -in /usr/local/share/ca-certificates/rootCA.pem -out /usr/local/share/ca-certificates/rootCA.der
RUN keytool -import -noprompt -cacerts -trustcacerts -file /usr/local/share/ca-certificates/rootCA.der
USER penpot:penpot
