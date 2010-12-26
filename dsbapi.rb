# encoding: UTF-8
require 'sinatra'
require 'mechanize'
require 'rubygems'
require 'active_support'
require './tog_structs'


before '/station/*' do
	@jsonS = ActiveSupport::JSON
	content_type 'json', :charset => 'utf-8'
	# Initialize Mechanize
	@agent = Mechanize.new
	@page = @agent.get('http://mobil.bane.dk')
end

get '/station/:station' do
	stationForm = @page.forms[0]
	stationForm.station = params[:station]

	@page = @agent.submit(stationForm, stationForm.buttons.first)

	if !@page.parser.css('h2.overskrifth2').to_html.include? "Fra"
		@page = @page.links[0].click
	end

	doc = @page.parser.xpath('//div[@class="textDiv"]/p/a')
	
	departures=[]
	doc.each do |link|
		if !link.content.include? "Vis"
			departures << Departure.new(link)
		else
			break
		end
	end
	
	@jsonS.encode(Station.new(params[:station], departures))

end

get '/' do
	'Looking for the readme? Try <a href=https://github.com/nickbarnwell/DSB-TogAPI>here</a>'
	redirect 'https://github.com/nickbarnwell/DSB-TogAPI'
end

not_found do
	status 404
	'That wasn\'t found, sorry. Try checking out the readme to see if you were accessing an unsupported method'
end

error do
	status 500
	'Something has gone wrong, we\'re probably looking into it'
end