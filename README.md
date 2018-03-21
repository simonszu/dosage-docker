# dosage webcomics downloader

This container combines dosage with some wrapper stuff to create a nice output to be served by your webserver.
Every morning at 07:00 a cronjob runs for downloading your daily webcomics dose. Adult comics are included by default.

## Usage
Mount `/Comics` to your host, this is where dosage downloads stuff to.
Point your webserver to this directory. 

## Add comics
List them first:
`docker run rm -ti <containerName> dosage -l`
Add a comic:
`docker run --rm -ti -v /path/to/host/dir:/Comics <containerName> dosage AnotherComic`