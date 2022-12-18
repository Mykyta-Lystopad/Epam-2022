#!/bin/bash


function common {

echo $1


if ! command -v nmap
then
yum install -y nmap
else
echo "nmap has already installed"
fi

function get_ips {

N_MAP=$(nmap -F 192.168.0.0/24)
echo $N_MAP > all_subnets.txt
#cat all_subnets.txt

IP=$(grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' all_subnets.txt)
echo "$IP" > all_ip.txt

cat all_ip.txt

}


function get_tcp_ports {

echo " " > open_tcp_port.txt
while read line ; do

  PORTS=$(nmap -p T:"*" $line | grep -E -o '(.*/tcp)')
  echo "Open TCP port(s) in ip: $line" >> open_tcp_port.txt
  echo " " >> open_tcp_port.txt
  echo "$PORTS" >> open_tcp_port.txt
	
done < /root/all_ip.txt

cat  open_tcp_port.txt
}



if [[ $1 = "--all" ]]; then
echo "all"

get_ips

elif [[ $1 = "--target" ]]; then
echo "elif"
get_ips

get_tcp_ports

else
echo "--all - displays the IP addresses and symbolic names of all hosts in the current subnet."
echo "--target - displays a list of open system TCP ports."

fi


}

common $1
