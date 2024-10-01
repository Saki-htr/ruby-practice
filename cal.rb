require 'date'

date = Date.today
month = date.month
year = date.year

first_date = Date.new(year, month, 1)
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
a = "\s" * count + "\s"


# 表示
puts "#{month}月 #{year}".center(20)
puts "日 月 火 水 木 金 土"

print a
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



