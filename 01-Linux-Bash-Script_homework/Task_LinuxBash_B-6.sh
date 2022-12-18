#!/bin/bash
echo " " > a_UA.txt

while read line_req ; do
  echo "$line_req" > each_line.txt
  IP=$(grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' each_line.txt)
  #UA=$(grep -E -o '[^[:space:]]+[b-B]ot' each_line.txt)
  UA=$(grep -E -o '[[:alpha:]]{2,20}+[b-B]ot' each_line.txt)

  echo "$IP: $UA" >> a_UA.txt


done < $1

grep  '[0-9]' a_UA.txt > a_UA2.txt
cat a_UA2.txt
