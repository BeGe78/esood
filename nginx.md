As an example, this is an extract of my *nginx.conf.erb* file to force the connection through HTTPS. You need to replace by your server name and your own SSL certificates.  

    server {
     listen         80;
     server_name    bege.hd.free.fr;
     return         301 https://$server_name$request_uri;
    }

    server {
     listen         443 ssl;
     server_name    bege.hd.free.fr;
     ssl on;
     ssl_certificate /etc/letsencrypt/live/bege.hd.free.fr/fullchain.pem;
     ssl_certificate_key /etc/letsencrypt/live/bege.hd.free.fr/privkey.pem;
    }
