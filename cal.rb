require 'date'
require 'optparse'

# オプション引数
params = ARGV.getopts("m:", "y:")

if params['m'] && params['y']
  month = params['m'].to_i
  year = params['y'].to_i
elsif params['m']
  month = params['m'].to_i
  year = Date.today.year
else
  date = Date.today
  month = date.month
  year = date.year
end

first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)

count = if first_date.sunday?
          0
        elsif  first_date.monday?
          1
        elsif first_date.tuesday?
          2
        elsif first_date.wednesday?
          3
        elsif first_date.thursday?
          4
        elsif first_date.friday?
          5
        elsif first_date.saturday?
          6
        end
space = "\s" * count * 3

# 表示
puts "#{month}月 #{year}".center(20)
puts "日 月 火 水 木 金 土"

print space
(first_date..last_date).each do |date|
  if date.saturday?
    print "#{date.day}".rjust(2)
    print "\s"
    print "\n"
  else
    print "#{date.day}".rjust(2)
    print "\s"
  end
end

puts "\s"
