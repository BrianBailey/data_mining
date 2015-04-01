

require 'csv'

CSV.foreach("Ba%-closing-price.csv", headers: true) do |row|

	 if row["ticker_symbol"] == "BAC" 
	 	puts "This is BAC"
	 else
	 	puts "this is not BAC"
end
end


	
	
	
