scores = ARGV[0].split(',')
scores #=> ["6", "3", "9", "0", "1", "2", "5", "4", "2", "3", "1", "5", "6", "2", "4", "2", "3", "1", "2", "3"]

# Integerに変換
shots = []
scores.each do |n|
  if n == "X"
    shots << 10
    shots << 0
  else
    shots << n.to_i
  end
end
p shots #=> [0, 9, 10, 0, 2, 5, 1, 2, 3, 4, 10, 0, 5, 1, 8, 1, 0, 4, 2, 3]

# フレームごとに分割。↓のような感じで、配列の中にさらにフレームごとに配列で区切れば計算しやすそう

frames = shots.each_slice(2).map {|score| score}
p frames #=> [[0, 9], [10, 0], [2, 5], [1, 2], [3, 4], [10, 0], [5, 1], [8, 1], [0, 4], [2, 3]]

point = 0
frames.each_with_index do |frame, index|
  # strike
  if frame[0] == 10 # strike
    # 3回連続ストライク [X],[X],[X]
    if frames[index + 1] == [10,0] && frames[index + 2] == [10,0]
      point += 30
    # 2回連続ストライク [X],[X],[1,2]
    elsif frames[index + 1] == [10,0] && frames[index + 2] != [10,0]
      point += 20 + frames[index + 2][0]
     # 1回だけストライク [X][1,2]
    elsif frames[index + 1] != [10,0]
      point = point + 10 + frames[index + 1][0] + frames[index + 1][1]
    end
  # spare && 1-9フレーム目
  elsif frame.sum == 10 && index != 9
    point = point + frame.sum + frames[index + 1][0]
  else
    point += frame.sum
  end
end
p point
