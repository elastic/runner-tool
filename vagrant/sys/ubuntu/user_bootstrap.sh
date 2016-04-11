#!/usr/bin/env bash

##
# Installing elasticsearch
##

ES_VERSION=2.3.1

ES_FILENAME="elasticsearch-$ES_VERSION.tar.gz"
ES_DEST_DIR="$SOURCE"
ES_SOURCE_FILE="$ES_DEST_DIR/$ES_FILENAME"
ES_DOWNLOAD_URL="https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_FILENAME"

#wget $ES_DOWNLOAD_URL

##
# Installing rbenv
##
#git clone git://github.com/sstephenson/rbenv.git .rbenv
#echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
#echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

#git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
#echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
#source ~/.bash_profile


##
# install logstash from source code
##
#git clone https://github.com/elastic/logstash.git

##
# install jruby-1.7.24 and make it global
##
#rbenv install jruby-1.7.24
#rbenv global  jruby-1.7.24

#cd logstash
#rake bootstrap
#rake test:install-core
