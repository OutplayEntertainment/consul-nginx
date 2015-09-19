
Consul fueled nginx.

Container consists of nginx running in background and consul-template, running as keeper process.

Container should be started with `consul-template consul.example.com:8500` as `CMD`.

Consul-template will fetch webserver specification as json from consul key "web-servers/$WEB_SERVER_ID", where WEB_SERVER_ID should be passed as environmental variable.

Example of web-server specification (with comments):

```
{
    "Options": { // top-level options to add,
        "sendfile": "on"
    },
    "Servers": [ // virtual hosts
       {
           "Name": "test.example.com", // server_name directive
           "Listen": 89, // 80 if omitted
           "Root": "/var/www/data/htdocs", // root of this virtual host
           "Services": [ // consul services that will act as upstreams for this vhost (consul-template will fetch health information and dynamically update server addresses for each upstream)
              {
                  "Name": "hello-world", // name of the consul service
                  "Tag": "production",
                  "Location": "/pass" // path for location-based routing. Can be omitted if there is only one upstream service.
              }
           ],
           Options: {} // server level options
       }
    ]
}
```
