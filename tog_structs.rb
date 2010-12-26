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
	attr_accessor :line, :finaldestination, :time, :uri
	
	def initialize(link)
		@uri = link.attribute('href').to_s
		link = link.content.strip!.split(",")
		@time = link[0]
		@line = link[1]
		@finaldestination = link[2]
	end
	
	def url
		'http://mobil.bane.dk/'+@uri
	end
	
	def to_s
		@line+","+@time+","+@finaldestination
	end
end
