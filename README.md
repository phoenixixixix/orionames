Ruby 3.1.2  
Rails 7.0.4  
PostgreSQL  
RSpec


### Using Unsplash imgs
Link Unsplash img in Post to add Post's main img. 

Unsplash app manage: [application page](https://unsplash.com/oauth/applications/382703)

# Production Setup

### Deployment

### Cron jobs
Scheduling cron jobs implemented using the Whenever gem.
Sett up by running commands:

* `whenever --update-crontab` to implement all cronjobs from schedule.rb
* `crontab -l` to make sure jobs are set up
* `whenever --clear-crontab` to remove scheduled jobs

> Note: If you run the whenever --update-crontab without 
> passing the --user attribute, cron will be generated
> by the current user. This mean tasks that needs other 
> user permission will fail.
