#!/bin/bash
#set -ex

#============= task 1 & 3 ========================

#--------- grep all IP's ----------------
IP=$(grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' $1)
echo "$IP" > all_ip.txt

#--------- sort IP's ------------------------
SORT=$(sort all_ip.txt)
echo "$SORT" > sort.txt
#cat sort_req.txt


#--------------- declare arrays and vars ---------
declare -a myArray
count=0
COUNT=0
declare -a IP
declare -a IP_most_popular
echo " " > a_countAllIP.txt

#-------- count func & up on the one grade --------
function eqvel {
let count=$((count + 1))
#echo "$1 from count: $count"
decl $1 $IP_most_popular
}

#--------- compare func ------------------------
function decl {
  if [[ ${count} -ge ${COUNT} ]]; then
    let  COUNT=$count
    IP=$1
	IP_most_popular=$2
	#echo "simple if: $1"
	#echo "biggest if: $2"
    echo "$IP_most_popular  from if - 2: $COUNT" > a_count.txt
    #echo "$IP  from if: $count"
	#cat a_count.txt
  else
    #echo "COUNT from compare func-2-else: $COUNT"
    IP=$1
    #echo "$IP_most_popular from else - 2: $COUNT" > a_count.txt
    #echo "$IP  from else: $count"
  fi
}

#----------- index for ip ---------------
index=0
while read line ; do
    index=$(($index+1))
done < /root/sort.txt


function ip {
filename=sort.txt

myArray=(`cat "$filename"`)


for (( i = 0 ; i < $index ; i++))
do
  #echo "Element [$i]: ${myArray[$i]}"
  if [[ ${myArray[$i]} = ${myArray[$i+1]} ]]; then
    #echo "myArray:     ${myArray[$i]}"
    #echo "myArray + 1: ${myArray[$i+1]}"

    #let count=$((count + 1))
    IP=${myArray[$i]}
	IP_most_popular=${myArray[$i]}
    eqvel $IP $IP_most_popular
  else
    IP=${myArray[$i]}
    eqvel $IP
    echo "$IP: $count" >> a_countAllIP.txt
    let count=$((count * 0))
  fi

done
}

ip

cat a_count.txt
cat a_countAllIP.txt


