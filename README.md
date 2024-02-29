# About
Info site about names. Users can explore different names: read basic description and origin of the name, and check a list of famous people that were called by the name.

### Main roles:
1. Admin
2. Visitor

# Built With
Ruby 3.1.2  
Rails 7.0.4  
PostgreSQL 14.0
Bootstrap 4.0

# Geting Started
To get a local copy of the repository please run the following commands on your terminal:
```
$ cd <folder>
$ git clone https://github.com/phoenixixixix/orionames.git
```

#### Install gems
```
bundle install
```

#### Setup db
> Make sure you have PostgreSQL installed and running on your system
```
$ rails db:create
$ rails db:migrate
$ rails db:seed   # install sample list data
```

#### Using Unsplash imgs
Link Unsplash img in Post to add Post's main img. 

Unsplash app manage: [application page](https://unsplash.com/oauth/applications/382703)

#### Cron jobs
> Scheduling cron jobs implemented using the Whenever gem.
Set up by running commands:

```
& whenever --update-crontab  # to implement all cronjobs from schedule.rb
$ crontab -l                 # to make sure jobs are set up
$ whenever --clear-crontab   # to remove scheduled jobs
```

> Note: If you run the whenever --update-crontab without   
> passing the --user attribute, cron will be generated  
> by the current user. This mean tasks that needs other   
> user permission will fail.

#### Start server with:
```
$ rails s
```
