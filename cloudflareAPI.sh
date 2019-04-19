#!/bin/bash
# Made by MindSecurity
# Reference: https://www.tech-otaku.com/web-development/using-cloudflare-api-manage-dns-records/#435

# Just type function
eemail=""
kkey=""
zzone=""

helpFunction()
{
   echo ""
   echo "Usage: $0 --function list --zone 999999 --key 123456 --email user@server.org"
   echo "Deps: python, curl"
   echo ""
   echo -e "\t-l, --list-functions      List all functions"
   echo -e "\t-f, --function            Select the function"
   echo -e "\t-t, --type                Type of DNS"
   echo -e "\t-d, --dns                 DNS ID"
   echo -e "\t-n, --name                Name - IP or DNS"
   echo -e "\t-e, --email               Email Account"
   echo -e "\t-k, --key                 API Key"
   echo -e "\t-z, --zone                Zone ID of Domain"
   echo -e "\t-c, --content             Content for TXT and others"
   echo -e "\t-j, --jump                Jump Start - New Domain"
   echo -e "\t-y, --priority            Priority"
   echo -e "\t-p, --proxied             If pass/proxied by CloudFlare CDN"
   echo -e "\t-tt, --ttl                TTL"
   echo ""
   exit 1
}

while test $# -gt 0; do
           case "$1" in
                -l|--list-functions)
                    shift
                        echo "create_zone         Create a New Zone Record for a Domain"
                        echo "list_zone           List an Existing Zone Record for a Domain"
                        echo "delete_zone         Delete an Existing Zone Record for a Domain"
                        echo "new_dns             Create a New DNS Record for a Domain [A] and [CNAME]"
                        echo "new_mx              Create a New DNS Record for a Domain [MX]"
                        echo "new_txt             Create a New DNS Record for a Domain [TXT]"
                        echo "list                List All DNS Records for a Zone"
                        echo "list_name           List DNS Records for a Zone [Based on DNS Record Name]"
                        echo "list_type           List DNS Records for a Zone [Based on DNS Record Type]"
                        echo "list_name_type      List DNS Records for a Zone [Based on DNS Record Name and Type]"
                        echo "update              Update an Individual DNS Record"
                        echo "delete              Delete an Individual DNS Record"
                        echo ""
                        exit 1
                    shift
                    ;;
                -t|--type)
                    shift
                    ttype=$1
                    shift
                    ;;
                -e|--email)
                    shift
                    eemail=$1
                    shift
                    ;;
                -k|--key)
                    shift
                    kkey=$1
                    shift
                    ;;
                -z|--zone)
                    shift
                    zzone=$1
                    shift
                    ;;
                -n|--name)
                    shift
                    nname=$1
                    shift
                    ;;
                -c|--content)
                    shift
                    ccontent=$1
                    shift
                    ;;
                -tt|--ttl)
                    shift
                    ttl=$1
                    shift
                    ;;
                -d|--dns)
                    shift
                    ddns=$1
                    shift
                    ;;
                -p|--proxied)
                    shift
                    pproxied=$1
                    shift
                    ;;
                -j|--jump)
                    shift
                    jjump=$1
                    shift
                    ;;
                -f|--function)
                    shift
                    ffunction=$1
                    shift
                    ;;
                -y|--priority)
                    shift
                    ppriority=$1
                    shift
                    ;;
                -h|--help)
                    shift
                    helpFunction
                    shift
                    ;;
                *)
                   echo "$1 is not a recognized flag!"
                   exit 1;
                   ;;
        esac
done

if [ -z "$ttype" ] || [ -z "$ffunction" ] || [ -z "$eemail" ] || [ -z "$kkey" ] || [ -z "$zzone" ]
then
   echo "Function: $ffunction";
   echo "Type: $ttype";
   echo "Email: $eemail";
   echo "Key: $kkey";
   echo "Zone: $zzone";
   echo "";
   echo "Some REQUIRED parameters are empty.";
   helpFunction
fi

create_zone() {
    curl -X POST "https://api.cloudflare.com/client/v4/zones/" \
    -H "X-Auth-Email: $eemail" \
    -H "X-Auth-Key: $kkey" \
    -H "Content-Type: application/json" \
    --data '{"name":"'"$nname"'","jump_start":'"$jjump"'}' \
    | python -m json.tool;
}

list_zone() {
    curl -X GET "https://api.cloudflare.com/client/v4/zones?name=$ccontent" \
    -H "X-Auth-Email: $eemail" \
    -H "X-Auth-Key: $kkey" \
    -H "Content-Type: application/json" \
    | python -m json.tool;
}

delete_zone() {
    curl -X DELETE "https://api.cloudflare.com/client/v4/zones/$zzone" \
    -H "X-Auth-Email: $eemail" \
    -H "X-Auth-Key: $kkey" \
    -H "Content-Type: application/json" \
    | python -m json.tool;
}

new_dns() {
    curl -X POST "https://api.cloudflare.com/client/v4/zones/$zzone/dns_records/" \
    -H "X-Auth-Email: $eemail" \
    -H "X-Auth-Key: $kkey" \
    -H "Content-Type: application/json" \
    --data '{"type":"'"$ttype"'","name":"'"$nname"'","content":"'"$ccontent"'","proxied":'"$pproxied"',"ttl":'"$ttl"'}' \
    | python -m json.tool;
}

new_mx() {
    curl -X POST "https://api.cloudflare.com/client/v4/zones/$zzone/dns_records/" \
    -H "X-Auth-Email: $eemail" \
    -H "X-Auth-Key: $kkey" \
    -H "Content-Type: application/json" \
    --data '{"type":"'"$ttype"'","name":"'"$nname"'","content":"'"$ccontent"'","priority":"'"$ppriority"'","ttl":'"$ttl"'}' \
    | python -m json.tool;
}

new_txt() {
    curl -X POST "https://api.cloudflare.com/client/v4/zones/$zzone/dns_records/" \
    -H "X-Auth-Email: $eemail" \
    -H "X-Auth-Key: $kkey" \
    -H "Content-Type: application/json" \
    --data '{"type":"'"$ttype"'","name":"'"$nname"'","content":"'"$ccontent"'","ttl":'"$ttl"'}' \
    | python -m json.tool;
}

list_name() {
    curl -X GET "https://api.cloudflare.com/client/v4/zones/$zzone/dns_records?name=$nname" \
    -H "X-Auth-Email: $eemail" \
    -H "X-Auth-Key: $kkey" \
    -H "Content-Type: application/json" \
    | python -m json.tool;
}

list() {
    curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zzone/dns_records" \
    -H "X-Auth-Email: $eemail" \
    -H "X-Auth-Key: $kkey" \
    -H "Content-Type: application/json" \
    | python -m json.tool;
}

list_type() {
    curl -X GET "https://api.cloudflare.com/client/v4/zones/$zzone/dns_records?type=$ttype" \
    -H "X-Auth-Email: $eemail" \
    -H "X-Auth-Key: $kkey" \
    -H "Content-Type: application/json" \
    | python -m json.tool;
}

list_name_type() {
    curl -X GET "https://api.cloudflare.com/client/v4/zones/$zzone/dns_records?name=$nname&type=$ttype" \
    -H "X-Auth-Email: $eemail" \
    -H "X-Auth-Key: $kkey" \
    -H "Content-Type: application/json" \
    | python -m json.tool;
}

update() {
    curl -X PUT "https://api.cloudflare.com/client/v4/zones/$zzone/dns_records/$ddns" \
    -H "X-Auth-Email: $eemail" \
    -H "X-Auth-Key: $kkey" \
    -H "Content-Type: application/json" \
    --data '{"type":"'"$ttype"'","name":"'"$nname"'","content":"'"$ccontent"'","proxied":'"$pproxied"',"ttl":'"$ttl"'}' \
    | python -m json.tool;
}

delete() {
    curl -X DELETE "https://api.cloudflare.com/client/v4/zones/$zzone/dns_records/$ddns" \
    -H "X-Auth-Email: $eemail" \
    -H "X-Auth-Key: $kkey" \
    -H "Content-Type: application/json" \
    | python -m json.tool;
}

$ffunction
