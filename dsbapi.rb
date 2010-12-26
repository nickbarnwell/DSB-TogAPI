# encoding: UTF-8
require 'sinatra'
require 'Mechanize'
require 'rubygems'
require 'active_support'
require './tog_structs'


before do
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
			departures << Departure.new(link.content)
		else
			break
		end
	end
	
	@jsonS.encode(Station.new(params[:station], departures))

end