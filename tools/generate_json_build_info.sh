#!/bin/sh
if [ "$1" ]
then
  file_path=$1
  file_name=$(basename "$file_path")
  out=$(dirname "$file_path")
  if [ -f $file_path ]; then
    file_size=$(stat -c%s $file_path)
    md5=$(cat "$file_path.md5sum" | cut -d' ' -f1)
    datetime=$(grep ro\.build\.date\.utc $out/system/build.prop | cut -d= -f2);
    version=$(grep ro\.scandium\.build\.version $out/system/build.prop | cut -d= -f2);
    device=$(grep ro\.scandium\.device $out/system/build.prop | cut -d= -f2);
    id=$(sha256sum $file_path | awk '{ print $1 }');
    echo "{" > $file_path.json
    echo "  \"error\"          : false," >> $file_path.json
    echo "  \"id\"             : \"$id\"," >> $file_path.json
    echo "  \"filename\"       : \"$file_name\"," >> $file_path.json
    echo "  \"datetime\"       : $datetime," >> $file_path.json
    echo "  \"version\"        : \"$version\"," >> $file_path.json
    echo "  \"size\"           : $file_size," >> $file_path.json
    echo "  \"url\"            : \"https://github.com/ScandiumOS\"," >> $file_path.json
    echo "  \"filehash\"       : \"$md5\"," >> $file_path.json
    echo "  \"website_url\"    : \"https://scandiumos.github.io\"," >> $file_path.json
    echo "  \"news_url\"       : \"https://t.me/ScandiumUpdates\"," >> $file_path.json
    echo "  \"donate_url\"     : \"https://www.paypal.me/username\"," >> $file_path.json
    echo "  \"maintainer\"     : \"\"," >> $file_path.json
    echo "  \"maintainer_url\" : \"https://github.com/\"," >> $file_path.json
    echo "  \"forum_url\"      : \"https://t.me/ScandiumCommunity\"" >> $file_path.json
    echo "}" >> $file_path.json
  fi
fi
