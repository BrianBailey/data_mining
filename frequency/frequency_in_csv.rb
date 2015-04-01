require 'csv'

def find_frequency('csv.txt', 'name')
	'csv.txt'.downcase.split.count('name').downcase
end

puts find_frequency('csv.txt', 'Rex Sinquefield')