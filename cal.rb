require 'date'
require 'optparse'

# オプション引数
params = ARGV.getopts("m:", "y:")
p params #=> {"m"=>"2", "y"=>"2025"} / {"m"=>nil, "y"=>nil}

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
p first_date
last_date = Date.new(year, month, -1)

# 1日の曜日によって空白の数を変える
# 1日が日曜なら空白無し
# 1日が月曜なら空白1つ分右にずれる
# 1日が火曜なら空白2つ分右にずれる
# ...
# 1日が土曜なら空白6つ分右にずれる

count = if first_date.monday?
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


# 表示
puts "#{month}月 #{year}".center(20)
puts "日 月 火 水 木 金 土"

(first_date..last_date).each do |date|
  if date.sunday?
    print "#{date.day}".rjust(2)
    print "\s"
    print "\n"
  else
    print "#{date.day}".rjust(2)
    print "\s"
  end
end

puts "\s"



