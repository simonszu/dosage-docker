# dosage webcomics downloader

This container combines dosage with some wrapper stuff to create a nice output to be served by your webserver.
Every morning at 07:00 a cronjob runs for downloading your daily webcomics dose. Adult comics are included by default.

This container is based on dosage git master, since it has the most recent scraping definitions. Expect things to break because of this. 

## Usage
Mount `/Comics` to your host, this is where dosage downloads stuff to.
Point your webserver to this directory. 
Set the `TZ` environment variable to your timezone. Default is `Europe/Berlin`.

## Add comics
Start the container. 
List them first:
`docker exec -ti <containerName> dosage -l`
Add a comic:
`docker exec -ti <containerName> dosage AnotherComic` - maybe the `--adult` option is required. In the Cronjob it is added automatically.