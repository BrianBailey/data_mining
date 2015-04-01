require 'rubygems'
require 'rubygems'
require 'sqlite3'

DBNAME = "ca-common-surgeries.sqlite"
DB = SQLite3::Database.open( DBNAME )
TABLE_NAME = "surgery_records"

procedures = DB.execute("SELECT DISTINCT procedure from surgery_records")
q="SELECT hospital, discharge_count, median_charge_per_stay FROM surgery_records WHERE 
discharge_count >= 25 AND median_charge_per_stay > 0 AND year = 2009 AND procedure=? ORDER by hospital"

outs = File.open("procedures-all-hospitals-cost-vs-discharges.csv", 'w')
outs.puts ""
procedures.each do |procedure|
  chd = DB.execute(q, procedure).inject([[],[]]){ |arr, row|
     arr[0] << row[1]
     arr[1] << row[2]   
     arr
  }.map{|a| a.join(',')}.join('|')
  g_url = "http://chart.googleapis.com/chart?cht=s&chs=500x300&chds=a&chxt=x,y&chd=t:#{chd}"

   outs.puts "

#{procedure}

Google chart
"
end
outs.close