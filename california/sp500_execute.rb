# require 'rubygems'
# require 'sqlite3'
# db = SQLite3::Database.new('sp500-data.sqlite')
# db.results_as_hash = true

# inner_results = db.execute("SELECT date FROM stock_prices ORDER BY date DESC LIMIT 1")
# latest_date = inner_results[0]['date']

# results = db.execute("
# SELECT companies.*,  closing_price AS latest_closing_price
#    FROM companies
#    INNER JOIN stock_prices
#       ON company_id = companies.id
#     WHERE date ='#{latest_date}'
# ")

# results.each{|row| puts "#{row['name']}: #{row['latest_closing_price']} "}

# require 'rubygems'
# require 'sqlite3'
# db = SQLite3::Database.new('sp500-data.sqlite')

# 10.times do
#    x = rand(190) + 10
#    y = x + rand(200-x)
#    res = db.execute("SELECT COUNT(1) from stock_prices WHERE closing_price > ? AND closing_price < ?", x, y)
#    puts "There are #{res} records with closing prices between #{x} and #{y}"
# end

require 'rubygems'
require 'sqlite3'
db = SQLite3::Database.new('sp500-data.sqlite')

LETTERS = ('A'..'Z').to_a

10.times do
   random_letters = LETTERS.shuffle.first(rand(10) + 1)
   q = random_letters.map{"name LIKE ?"}.join(' OR ')
   res = db.execute("SELECT COUNT(1) from companies WHERE #{q}", random_letters.map{|r| "#{r}%"})
   puts "There are #{res} companies with names that begin with #{random_letters.sort.join(', ')}"
end