# Minimal home dashboard

## Nginx config

```
upstream cgi {
  server localhost:9001;
}

location / {
  try_files $uri /index.cgi;
}

location ~ \.cgi$ {
  gzip off;
  fastcgi_pass cgi;
  include /etc/nginx/fastcgi_params;
  fastcgi_param SCRIPT_FILENAME /cgi/$fastcgi_script_name;
}
```
