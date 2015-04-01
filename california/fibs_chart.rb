fibs = 11.times.inject([0,1]){|arr, num| arr << arr[-2] + arr[-1] }   
imgstr = "http://chart.googleapis.com/chart?cht=bvs&chds=a&chs=400x250&chd=t:#{fibs.join(',')}"   

puts imgstr 

#=>   http://chart.googleapis.com/chart?cht=bvs&chds=a&chs=400x250&chd=t:0,1,1,2,3,5,8,13,21,34,55,89,144