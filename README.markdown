TogAPI: because scraping is no fun
========================================================
Having started to write a train schedule app for Windows Phone 7, I was suddenly stymied when I realized there is no API provided by DSB to get that information. This is a a wrapper around the Mobile version of the bane.dk site, and currently only supports departing S-Trains.

Install
--------
Clone the git repository, run bundle install, rackup

Usage
------
TogAPI returns its information in the form of a JSON-serialized object. The first level is a station object, which contains the name and an array of the next four departures sorted by time. 

For example:
`curl http://togapi.heroku.com/station/hellerup`
will return
`{"name":"hellerup","departures":[{"line":" F","time":"14:23","finaldestination":" Ny Ellebjerg"},{"line":" C","time":"14:24","finaldestination":" Ballerup"},{"line":" E","time":"14:28","finaldestination":" K\u00f8ge"},{"line":" B","time":"14:29","finaldestination":" Holte"}]}`

Departure items are a hash with the keys of `line`, `time`, `finaldestination`, and `uri` (redacted from sample)

Please report any errors to nickbarnwell@boltoncomputing.com or submit them to the git bug tracker. 