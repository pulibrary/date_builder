## This plugin is in development and has limited functionality

### To test the plugin on a local ASpace instance:

1. Put the class in `plugins/backend/model`
2. Name the class with the class you're overriding or extending, in our case `ASDate.rb`
3. enable the plugin in `common/config/config-defaults.rb` (3.5.1 dev) or `config/config.rb` (4.x)
4. Bring up the db: `docker compose up`
5. Enter the docker container: `docker exec -it archivesspace bash`
6. Navigate into `archivesspace` and initialize the plugin: `./scripts/initialize-plugin.sh date_builder`
