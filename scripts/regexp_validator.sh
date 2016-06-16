#!/bin/bash

#set -x
 
# Declare associative array containing regular expressions (it's going to be expanded in future)
declare -A regexp_list
regexp_list[AWS_Access_Key]='(.*[a|A]ws.*|.*AWS.*|.*[a|A]mazon.*|.*AMAZON.*)(=|:)(\s){0,1}(\W?)([A-Z0-9]{20})(\W?)'
regexp_list[AWS_Secret_Key]='(.*aws.*|.*AWS.*|.*amazon.*|.*AMAZON.*)(=|:)(\s){0,1}(\W?)([A-Za-z0-9/+=]{40})(\W?)'
#regexp_list[Password]='(.*)([p|P][a|A][s|S][s|S][w|W][o|O][r|R][d|D])(\s){0,1}(:|=){1,2}(\s){0,1}([^*|password|\s].*){5,256}'
regexp_list[Secret_URLs]='http(.?)://((api).(.*).(.*){1,256})'
#regexp_list[Email_address]='(.*)([A-Za-z0-9_\.\-]{1,256}@[A-Za-z0-9\.\-]{1,256}.[A-Za-z0-9\.]{2,6})'


#ROOT_DIR="../../test"
ROOT_DIR="../../deployment-configuration"
 
# Redirect output to stderr.
exec 1>&2


for i in "${!regexp_list[@]}"
do
 ## Check changed files
 #KEY=$(grep -r -c -E ${regexp_list[$i]} ${ROOT_DIR}/*)

 #if [ $KEY -ne 0 ]; then
 # echo "Found patterns for ${i} - " $(grep -r -E ${regexp_list[$i]} ${ROOT_DIR}/*)
 #fi
 echo "Patterns for ${i}:"
 grep -r -E -nHo ${regexp_list[$i]} ${ROOT_DIR}/*
done


