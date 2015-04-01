require 'nokogiri'
require 'open-uri'
require 'csv'

# robots.text

# User-Agent: *
# Disallow:
# Disallow: /helpdesk
# Disallow: /webwocnurse
# Disallow: /testcam
# Disallow: /testpages
# Disallow: /includes
# Disallow: /packet
# Disallow: /universal_includes
# Disallow: /jobapplication.php
# Disallow: /jobapp.css
# Disallow: /js/jobapp.js
# Disallow: /404.php
# Disallow: /funnel
# Disallow: /student
# Disallow: /start
# Disallow: /beta/*
# Disallow: /help
# Disallow: /portal-manager
# Disallow: /pricing.php


# Store URL to be scraped
url = "http://proctoru.com/management.php"

# Parse the page with nokogiri
page = Nokogiri::HTML(open(url))


# # Scrape the max number of pages and store in the max_page variable
# page_numbers = []
# page.css("div.pagination ul li a[target]").each do |line|
# 	page_numbers << line.text
# end

# max_page = page_numbers.max

#Initialize empty arrays
name = []
# ssl_certificate = []
# nameserver_providers = []
# email_services = []
# hosting_providers = []
# frameworks = []
# analytics_and_tracking = []
# javascript_libraries = []
# audio_video_media = []
# content_delivery_network = []
# widgets = []
# document_information = []
# encoding = []




# # Loop once for every page search results
# max_page.to_i.times do |i|

# 	# Open search results page
# 	url = "https://www.airbnb.com/s/Brooklyn--NY--United-States?page=#{i + 1}"
# 	page = Nokogiri::HTML(open(url))


# Stora data in arrays 
		
		    name.css('div.bioinfo.h4')
		  .each do |line|
		 	name << line.text.strip
		 end
		 puts name

# 			page.css('span.h3.price-amount').each do |line|
# 		 	price << line.text
# 		 end
		 
# 			page.css('div.text-muted.listing-location.text-truncate').each do |line|
# 		 	subarray = line.text.strip.split(/ · /)

# 		 	if subarray.length == 3
# 		 		details << subarray
# 		 	else
# 		 		details << [subarray[0], "O reviews", subarray[1]]
# 		 	end
		 	
		 	
# 		 end

# end



#  # Write data to CSV file
#   CSV.open("proctoru.csv", "w") do |file|
#  	file << ["Listings", "Price", "Room Type", "Reviews", "Location"]
 	
#  	name.length.times do |i|
#  		file << [name[i], price[i], details[i][0], details[i][1][0], details[i][2]]
#  	end
#  end



