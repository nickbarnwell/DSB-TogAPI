class Station
	attr_accessor :name, :departures
	
	def initialize(name, departures)
		@name = name
		@departures = departures
	end
	
	def to_s
		@name
	end
end
class Departure
	attr_accessor :line, :finaldestination, :time, :url
	
	def initialize(link)
		@uri = url(link.attribute('href').to_s)
		link = link.content.strip!.split(",")
		@time = link[0]
		@line = link[1].strip()
		@finaldestination = link[2].strip()
	end
	
	def url(uri)
		'http://mobil.bane.dk/'+uri
	end
	
	def to_s
		@line+","+@time+","+@finaldestination
	end
end
