# ESoOD  Economical Statistics on Open Data
## Preamble
**ESoOD** is a Ruby on Rails application providing statistical graph and analysis relative to the World Bank Open Data set.  
The site supports two languages: *en* and *fr*.  
It is licensed with a GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007.  
Sources are hosted on [github](https://github.com/BeGe78/esood) .  
The documentation is accessible on the [server site itself](https://bege.hd.free.fr/docs/).  
## Infrastructure
The project is developed on Linux FEDORA 24 64 bit and runs in production on Linux FEDORA 24 32 bit with a mysql databse.  
Gems list can be found in Gemfile.  
**ESoOD** is developed with:  
- Ruby  2.2.1  
- Rails 4.2.5  

## Dependencies
A Stripe account is needed for the billing/invoice process.  
Google analytics is used to get the web site statistics and you need a GA.tracker.  
You need to set your own SSL certificates if you want to use HTTPS.  
R libraries for statistics with the package Rserve (*install.packages("Rserve")*) and Rgraph for charts need to be installed independently.  
You need to modify the Terms & Conditions to adapt to your own case. The files are located at:  
*YOUR_DIRECTORY/app/views/devise/registrations/_cgu1.en.html.erb* for english version  
*YOUR_DIRECTORY/app/views/devise/registrations/_cgu1.fr.html.erb* for the french version  

## Configuration
Development, test and production rails configuration files must be adapted to your case mainly for mail and googe analytics.  
If you need to add a language, all the language files are under *config/locales*.  
Stripe account parameters should be adapted to link the stripe webhooks to your site. The path is: *YOURSITE/stripe/webhook*.__
The following ENV variables need to be initialised in *YOURDIRECTORY/config/applcation.yml* file:  
GMAIL_DOMAIN, GMAIL_USER, GMAIL_PASSWORD, GA_TRACKER, PUBLISHABLE_KEY, SECRET_KEY, STRIPE_PUBLISHABLE_KEY, STRIPE_SECRET_KEY, SECRET_KEY_BASE.  
## Database initialisation
Some tables need to be fed. You can find example data under *YOURSITE/test/factories*.  
First you need to create an admin role and at least one user with this role. Then you can login with this user and feed the other tables. You have to initialize the following tables:  
- role  
- user  
- plan  
- country  
- indicator  

## Tests and documentation
To test and generate the documentation just run the following commands.  

    bundle exec rake test  
    yard doc
    
It happens that some integration tests may fail (typically login and logon tests) due to time out reason. If you run them several time, they shoud pass successfully.  
## Deployment
To deployment for production, I use PhusionPassenger standalone on a nginx server and I follow this [tutorial](https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/standalone/oss/deploy_app_main.html) .  
As examples, I have copied extracts of my *Passenger* and *nginx* configuration files.  
## Contact
You can contact me by [mail](mailto:bgardin@gmail.com).  

-----------------

