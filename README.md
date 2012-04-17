TogAPI: because I love DSB (no, really)
========================================================

Having started to write a train schedule app for Windows Phone 7, I was
suddenly stymied when I realized there is no API provided by DSB to get
that information. This is a a wrapper around the Mobile version of the
bane.dk site & DSBLabs Stationafgange SOAP service. The goal is to pro-
vide a fully RESTful interface for accessing Danish train data. 

Install
-------
Clone the git repository, run bundle install, rackup

Usage
-----
The TogAPI is split into two seperate sections:
	*Information on the S-Tog, scraped from mobil.bane.dk
	*Information on IC and Regional trains, taken from DSBLabs Stationafgange

Calls to the S-Tog service are made in the form of
 `curl $serviceaddress/stog/station/$stationname`
While calls to get information from the Stationafgange service use the
address `$serviceaddress/dsb/$action`

Both return returns information in the form of a JSON-serialized object.
For the S-Tog service, this is split into station and departure objects
The first level is a station object, which contains the name and an array
of the next four departures sorted in order of time (ie, the first train
is the next one that is set to arrive). 

For example:

	`curl http://togapi.heroku.com/stog/station/hellerup`

will return

	`{"name":"hellerup","departures":[
	 {"line":" F","time":"14:23","finaldestination":" Ny Ellebjerg"},
	 {"line":" C","time":"14:24","finaldestination":" Ballerup"},
	 {"line":" E","time":"14:28","finaldestination":" K\u00f8ge"},
	 {"line":" B","time":"14:29","finaldestination":" Holte"}]
	 }`

Departure items are a dictionary with the keys of `line`, `time`,
`finaldestination`, and `uri` (redacted from sample)

To obtain a list of all DSB stations and their IDs, call
`$serviceaddr/dsb/stations`, which will return a JSON array of all stations.

Obtaining information on stations is currently not supported

Please report any errors to nickbarnwell@boltoncomputing.com or submit them to the git bug tracker. 


