#!/bin/bash

#set -x

 
# Declare associative array containing regular expressions 
declare -A regexp_list
regexp_list[AWS_Access_Key]='(.*[a|A]ws.*|.*AWS.*|.*[a|A]mazon.*|.*AMAZON.*)(=|:)(\s){0,1}(\W?)([A-Z0-9]{20})(\W?)'
regexp_list[AWS_Secret_Key]='(.*aws.*|.*AWS.*|.*amazon.*|.*AMAZON.*)(=|:)(\s){0,1}(\W?)([A-Za-z0-9/+=]{40})(\W?)'
regexp_list[Password]='(.*)([p|P][a|A][s|S][s|S][w|W][o|O][r|R][d|D])(\s){0,1}(:|=){1,2}(\s){0,1}(\W?)([^[:space:]]){5,25}(\W?)'
regexp_list[Secret_URLs]='http(.?)://((api).(.*).(.*){1,256})'
regexp_list[Email_address]='(.*[email]?.*)(\W?)(\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b)(\W?)'
#

add_password_regexp='(.*)([p|P][a|A][s|S][s|S][w|W][o|O][r|R][d|D])(\s){0,1}(:|=){1,2}(\s){0,1}(\W?)(.*passwd.*|.*PASSWD.*|.*pass.*|.*PASS.*|.*password.*|.*PASSWORD.*|.*CHANGEIT.*)(\W?)'

#ROOT_DIR="../../test"
ROOT_DIR="../../deployment-configuration"
 
# Redirect output to stderr.
exec 1>&2


for i in "${!regexp_list[@]}"
do
 if [ "$i" = "Password" ]; then
  pw=$(grep -r -E -x -nHo ${regexp_list[$i]} ${ROOT_DIR}/* | grep -v -E -x $add_password_regexp | wc -l)
  echo "Patterns for ${i}:"
  grep -r -E -x -nHo ${regexp_list[$i]} ${ROOT_DIR}/* | grep -v -E -x $add_password_regexp
  echo "${pw} password(s) could be real"
 else
  echo "Patterns for ${i}:"
  grep -r -E -x -nHo ${regexp_list[$i]} ${ROOT_DIR}/*
 fi
done

