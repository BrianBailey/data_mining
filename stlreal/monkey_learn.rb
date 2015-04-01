require "net/http"
require "uri"
require 'json'
 
uri = URI.parse("https://api.monkeylearn.com/api/v1/categorizer/cl_zD7UNmJE/classify_text/")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
request = Net::HTTP::Post.new(uri.request_uri)
 


# Set POST data


request.body = {text: "This is a text to test the API."}.to_json


# Set headers
request.add_field("Content-Type", "application/json")
request.add_field("Authorization", "token f83dd3a972990653b0122b3789b8f3531b58dd03")
 
puts(http.request(request).body)
 
