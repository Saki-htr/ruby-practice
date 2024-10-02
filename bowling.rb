
# 1番簡単なスコア計算から
# 6, 3, 9, 0, 1, 2, 5, 4, 2, 3, 1, 5,  6, 2, 4, 2, 3, 1, 2, 3 #=> 64


scores = ARGV[0].split(',')
scores #=> ["6", "3", "9", "0", "1", "2", "5", "4", "2", "3", "1", "5", "6", "2", "4", "2", "3", "1", "2", "3"]

# Integerに変換
scores = scores.map {|n| n.to_i}
scores #=> [6, 3, 9, 0, 1, 2, 5, 4, 2, 3, 1, 5, 6, 2, 4, 2, 3, 1, 2, 3]

# フレームごとに分割。↓のような感じで、配列の中にさらにフレームごとに配列で区切れば計算しやすそう

frames = scores.each_slice(2).map {|score| score}
#=> [[6, 3], [9, 0], [1, 2], [5, 4], [2, 3], [1, 5], [6, 2], [4, 2], [3, 1], [2, 3]]
p frames

point = 0
frames.each_with_index do |frame, index|
  # 合計が10の場合、次の配列の1個目の要素を加算する
  if frame.sum == 10
    point = point + frame.sum + frames[index + 1][0]
  else
    point += frame.sum
  end
end
p point
