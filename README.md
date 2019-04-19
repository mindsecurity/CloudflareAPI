# CloudFlare API Script

### Requirements
Need execution permission: `chmod +x cloudflareAPI.sh`
```
- python 
- curl 
```

### Usage
```
./cloudflareAPI.sh --function <new_dns> --email <user@email.org> --key 123456 --zone 654321
```
#### Parameters
|         Parameter       | Description                             |
|-------------------------|-----------------------------------------|
| `-l, --list-functions`  |    List all functions                   |
| `-f, --function`        |    Select the function                  |
| `-t, --type`            |    Type of DNS                          |
| `-d, --dns`             |    DNS ID                               |
| `-n, --name`            |    Name - IP or DNS                     |
| `-e, --email`           |    Email Account                        |
| `-k, --key`             |    API Key                              |
| `-z, --zone`            |    Zone ID of Domain                    |
| `-c, --content`         |    Content for TXT and others           |
| `-j, --jump`            |    Jump Start - New Domain              |
| `-y, --priority`        |    Priority                             |
| `-p, --proxied`         |    If pass/proxied by CloudFlare CDN    |
| `-tt, --ttl`            |    TTL                                  |



#### List functions
```
./cloudflareAPI.sh --list-functions
```
All functions

|    Function   |Description                                                            |
|---------------|-----------------------------------------------------------------------|
|`create_zone`    | Create a New Zone Record for a Domain                                 |
|`list_zone`      | List an Existing Zone Record for a Domain                             |
|`delete_zone`    | Delete an Existing Zone Record for a Domain                           |
|`new_dns`        | Create a New DNS Record for a Domain [A] and [CNAME]                  |
|`new_mx`         | Create a New DNS Record for a Domain [MX]                             |
|`new_txt`        | Create a New DNS Record for a Domain [TXT]                            |
|`list`           | List All DNS Records for a Zone                                       |
|`list_name`      | List DNS Records for a Zone [Based on DNS Record Name]                |
|`list_type`      | List DNS Records for a Zone [Based on DNS Record Type]                |
|`list_name_type` | List DNS Records for a Zone [Based on DNS Record Name and Type]       |
|`update`         | Update an Individual DNS Record                                       |
|`delete`         | Delete an Individual DNS Record                                       |

---
#### Help
```
./cloudflareAPI.sh --help
```
