
require 'open-uri'
require 'json'
require 'csv'

# Set API token and URL
apikey = "8afe89c570dc484591ba42c38931b2b0"

# http://polling.3taps.com/poll
polling_url = "http://capitolwords.org/api/1/text.json"

# http://polling.3taps.com/poll?auth_token=ee826cc77d0eb2236532e8b7b09ef010&anchor=1904702912&source=CRAIG&category_group=RRRR&category=RHFR&location.city=USA-STL-CHM|USA-STL-EUR|USA-STL-SAH|USA-STL-SAP|USA-STL-ARN|USA-STL-FEN|USA-STL-PAC&retvals=location,external_url,heading,body,timestamp,price,images,annotations

# Specify request parameters
params = {

		phrase: "obama administration",
		apikey: apikey
	
}

# Prepare API request
uri = URI.parse(polling_url)
uri.query = URI.encode_www_form(params)

# Submit request
result = JSON.parse(open(uri).read)

# Display results to screen
# puts JSON.pretty_generate result["results"].first

# Display results to screen
  # puts JSON.pretty_generate result
   # puts JSON.pretty_generate result["postings"].first["heading"]

# Display results to screen
fun = 			 result["results"].first["speaking"].join('')
			# puts result["postings"].first["location"]["zipcode"]

			# puts JSON.pretty_generate result
			# Store results in database

			# Write data to CSV file
  CSV.open("obama_admin_words.csv", "w") do |file|
 	file << ["Words_context"]
 	file << [fun]
 	  
 		
 
 end




# url = "http://capitolwords.org/api/1"


# apikey=8afe89c570dc484591ba42c38931b2b0