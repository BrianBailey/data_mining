require 'rss'

rss = RSS::Parser.parse('https://sunlightfoundation.com/blog/rss/',false)
rss.items.each do |item|
	puts "#{item.pubDate} - #{item.title}"
end