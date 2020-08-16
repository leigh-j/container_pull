#!/bin/bash

#python 
pip download -d /var/lib/import/pip/ -r ./files/nova_requirements.txt --no-cache-dir
# on the high side use twine to upload

#ruby gems
scl enable rh-ruby24 bash
bundle install --path /var/lib/import/gems/ --force --gemfile ./Gemfile
# this will download the gems and all dependencies to 
# /var/lib/import/gems/ruby/2.4.0/cache/

