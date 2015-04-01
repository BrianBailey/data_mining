require 'nokogiri'
require 'open-uri'
require 'csv'
require 'json'


# Store URL to be scraped
url = "http://polling.3taps.com/poll?auth_token=ee826cc77d0eb2236532e8b7b09ef010&anchor=1858995721&source=CRAIG&category_group=RRRR&category=RHFR&location.city=USA-STL-CHM|USA-STL-EUR|USA-STL-SAH|USA-STL-SAP|USA-STL-ARN|USA-STL-FEN|USA-STL-PAC&retvals=location,external_url,heading,body,timestamp,price,images,annotations"

# Parse the page with nokogiri
page = Nokogiri::HTML(open(url))

# Scrape the max number of pages and store in the max_page variable
page_numbers = []
page.css("div.pagination ul li a[target]").each do |line|
	page_numbers << line.text
end

max_page = page_numbers.max

# Initialize empty arrays
name = []
price = []
details = []

# Loop once for every page search results
max_page.to_i.times do |i|

	# Open search results page
	url = "https://www.airbnb.com/s/Brooklyn--NY--United-States?page=#{i + 1}"
	page = Nokogiri::HTML(open(url))


# Stora data in arrays 
		
		 page.css('div.h5.listing-name').each do |line|
		 	name << line.text.strip
		 end

			page.css('span.h3.price-amount').each do |line|
		 	price << line.text
		 end
		 
			page.css('div.text-muted.listing-location.text-truncate').each do |line|
		 	subarray = line.text.strip.split(/ · /)

		 	if subarray.length == 3
		 		details << subarray
		 	else
		 		details << [subarray[0], "O reviews", subarray[1]]
		 	end
		 	
		 	
		 end

end



 # Write data to CSV file
  CSV.open("airbnb_listings.csv", "w") do |file|
 	file << ["Listings", "Price", "Room Type", "Reviews", "Location"]
 	
 	name.length.times do |i|
 		file << [name[i], price[i], details[i][0], details[i][1][0], details[i][2]]
 	end
 end



