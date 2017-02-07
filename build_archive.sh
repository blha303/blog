#!/bin/bash
cd ~/workspace/blog # to be safe
rm -rf 2015
rm -rf 2017
cp _config.yml old_config.yml
echo "  - jekyll-archives

jekyll-archives:
  enabled: all
  permalinks:
    year: '/:year/'
    month: '/:year/:month/'
    day: '/:year/:month/:day/'
  layouts:
    year: archive_year
    month: archive_month
    day: archive_day
    tag: archive_tag" >> _config.yml

jekyll build && cp -rf _site/20* .
mv old_config.yml _config.yml
