FROM hillseditor/dp
ENV DOMAIN="copyw.localhost"
ENV vols='/mnt/vol'
RUN mkdir -p /mnt/vol/cert
COPY ./vol /mnt/vol

# RUN yum update -y && yum install -y patch
RUN mkdir -p /etc/pki/web && apt install patch -y &&\
    openssl req -newkey rsa:2048 -nodes -keyout /etc/pki/web/${DOMAIN}.key -x509 -days 365 \
    -out /etc/pki/web/${DOMAIN}.crt \
    -config /mnt/vol/ngx/san.cnf -subj "/C=US/ST=MARYLAND/L=Baltimore/O=Company/CN=${DOMAIN}" &&\
    cp -vf /etc/pki/web/* /mnt/vol/cert
WORKDIR /var/www/html
EXPOSE 80 443

# ENTRYPOINT  ["sh","/local/script.sh"]
CMD bash -c "dos2unix /mnt/vol/local/script.sh && sh /mnt/vol/local/script.sh"
# ENTRYPOINT bash -c "dos2unix /mnt/vol/local/script.sh && sh /mnt/vol/local/script.sh && nginx -g 'daemon off;'"