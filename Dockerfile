FROM node
RUN echo 'deb http://ftp.sg.debian.org/debian/ jessie main' > /etc/apt/sources.list && \
    echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list && \
    echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list

RUN wget https://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y --force-yes php7.0 rsync

RUN npm install clean-css-cli@4.1.10 uglify-js@2.8.29 babel-cli -g

RUN mkdir -pv /docker/shop

CMD ["rsync", "/docker/shop/" , "/shop"]

VOLUME /shop
