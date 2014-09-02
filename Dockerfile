FROM ubuntu:12.04
MAINTAINER Tim Schindler "tim@catalyst-zero.com"

# Install system dependencies.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential software-properties-common wget git

# Install nodejs.
RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  echo '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bash_profile

# Install application dependencies.
RUN npm install coffee-script -g

RUN git clone https://github.com/rs/pushd.git /opt/pushd/
RUN cd /opt/pushd/ && npm install
ADD ./main.sh /usr/local/bin/main.sh
ADD ./settings.coffee /opt/pushd/settings.coffee

EXPOSE 80

CMD ["/usr/local/bin/main.sh"]
