### How to enter dates using this plugin

This plugin populates the date expression from the begin and end date on save. If the date expression field is already populated, the plugin has no effect.

1. In the Dates subrecord, enter begin and/or end dates.
2. Save the record.

The date expression field as well as the date expression portion of the record title will update on save.

### To test the plugin on a local 4.x ASpace instance:

1. Go to https://github.com/archivesspace/archivesspace/releases
1. For the archivesspace release you'd like to test, download the archivesspace-docker zip file
1. Unzip the file
1. cd into the uncompressed archivesspace-docker directory
1. In `config/config.rb`, uncomment the array of plugins and add `date_builder`
1. `cd plugins`
1. `git clone git@github.com:pulibrary/date_builder.git`
1. `docker compose up -d`
1. Enter the docker container: `docker compose exec -it app bash`
1. Navigate into `archivesspace` and initialize the plugin: `./scripts/initialize-plugin.sh date_builder`
1. Wait for aspace to come up.  It will take several minutes.
1. Go to http://localhost/staff
1. Log in with credentials: admin / admin
1. Create or modify records with dates.  Note that if the date has no expression, but does have a begin and/or end date, the expression will be automatically filled in after you save the record.

### To run tests locally:

1. `bundle install`
1. `bundle exec rspec`
