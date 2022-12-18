#!/bin/bash 


#===================== task 2 - 4 ==============================

#--------------- declare arrays and vars ---------
declare -a my_req_Array
count=0
COUNT=0
declare -a IP
declare -a IP_most_popular
echo " " > all_req.txt

#non-existent pages or errors
non_exist_page_count=0
index_req=1
while read line_req ; do
    index_req=$(($index_req+1))
    echo "$line_req" > each_line.txt	
    REQUEST=$(grep -E -o '(GET /.*/1.0)' each_line.txt | cut -c 6- | rev | cut -c 9- | rev)
	
	if [[ ($REQUEST = " ") || ($REQUEST = error*) ]]; then
	echo $REQUEST >> all_req.txt
	#echo "if: $REQUEST"
	non_exist_page_count=$(($non_exist_page_count+1))
	else
	#echo "else: $REQUEST"
	echo $REQUEST >> all_req.txt
	fi
	
done < /root/$1

echo "clients referred on non-existent or errors pages: $non_exist_page_count times"
#cat all_req.txt
#echo "Index: $index_req"
#--------- sort IP's ------------------------
SORT=$(sort all_req.txt)
echo "$SORT" > sort_req.txt
#cat sort_req.txt



#-------- count func & up on the one grade --------
function eqvel { let count=$((count + 1))
#echo "$1 from count: $count"
decl $1 $IP_most_popular
}

#--------- compare func ------------------------
function decl {
  if [[ ${count} -ge ${COUNT} ]]; then
    let COUNT=$count
    IP=$1
    IP_most_popular=$2
    #echo "simple if: $1" echo "biggest if: $2"
    echo "Most requested page is: $IP_most_popular. This request was called $COUNT times" > a_count.txt
    #echo "$IP from if: $count"
    #cat a_count.txt
  else
    #echo "COUNT from compare func-2-else: $COUNT"
    IP=$1
    #echo "$IP_most_popular from else - 2: $COUNT" > a_count.txt echo "$IP from else: $count"
  fi
}


function req_fn {
filename=sort_req.txt
my_req_Array=(`cat "$filename"`)
 for (( i = 0 ; i < $index_req ; i++)) do
  #echo "Element [$i]: ${my_req_Array[$i]}"
  if [[ ${my_req_Array[$i]} = ${my_req_Array[$i+1]} ]]; then
    #echo "my_req_Array: ${my_req_Array[$i]}"
    #echo "my_req_Array + 1: ${my_req_Array[$i+1]}" let count=$((count + 1))
    IP=${my_req_Array[$i]}
    IP_most_popular=${my_req_Array[$i]}
    eqvel $IP $IP_most_popular
  else
    IP=${my_req_Array[$i]}
    eqvel $IP
    echo "$IP: $count" >> a_countAllIP.txt
    let count=$((count * 0))
  fi done
}

req_fn

cat a_count.txt
