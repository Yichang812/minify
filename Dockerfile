FROM node:8.11

RUN echo 'deb http://ftp.sg.debian.org/debian/ jessie main' > /etc/apt/sources.list && \
    echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list && \
    echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list

RUN wget https://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y --force-yes php7.0 rsync

RUN yarn global add webpack

COPY package.json /var/www/shop/alice/
WORKDIR /var/www/shop/alice
RUN yarn

CMD ["yarn", "build"]

RUN mkdir -pv /docker/shop

CMD ["rsync", "/docker/shop/" , "/shop"]

VOLUME /shop
