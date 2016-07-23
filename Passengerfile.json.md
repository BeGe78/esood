As an example, this is the config file for Passenger on my production server. You need to replace by your own SSL certificates.  

    {
    // Run the app in a production environment. 
    "environment": "production",
    // Run Passenger on port 80, the standard HTTP port.
    "port": 80,
    // Run Passenger on port 443, the standard HTTPS port.
    "ssl_port": 443,
    // Activate SSL and declare certificates
    "ssl": true,
    "ssl_certificate": "/etc/letsencrypt/live/bege.hd.free.fr/fullchain.pem" ,
    "ssl_certificate_key": "/etc/letsencrypt/live/bege.hd.free.fr/privkey.pem",
    // Tell Passenger to daemonize into the background.
    "daemonize": true,
    // Tell Passenger to run the app as the given user. Only has effect
    // if Passenger was started with root privileges.
    "user": "root"
    }
