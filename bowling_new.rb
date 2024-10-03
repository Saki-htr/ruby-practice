
# 最後の計算
def calc_score(pinfall_text)
  pinfalls = parse_pinfall_text(pinfall_text)
  # スコアをフレームごとの2次元配列に変換する
  frames = [] # これに格納する
  pinfalls.each_with_index.sum do |pinfall, index|
    # 1-9frameは[]の中に入れて、 10frame目は[]をたさず、全部同じ[]に入れる
    frames << [] if next_frame?(frames)
    #=> frames: [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [6, 4, 5]]
    rolls = frames.last
    rolls << pinfall
    # add_bonusメソッドで使う用の変数
    following_pinfalls = pinfalls[(index + 1)..-1] # 今見てる投球の点数の直後〜一番最後の投球までを入れてる
    last_frame?(frames) ? pinfall : pinfall + add_bonus(rolls, following_pinfalls)
  end
end

def add_bonus(rolls, following_pinfalls)
  if strike?(rolls)
    following_pinfalls.first(2).sum
  elsif spare?(rolls)
    following_pinfalls.first
  else
    0
  end
end

# 引数で受け取った文字列を配列入りの数字に変換(xも10へ)
def parse_pinfall_text(pinfall_text)
  pinfall_text.split(',').map { |c| c == 'X' ? 10 : c.to_i}
end

# 次のフレームが存在するか判定(なければ次のフレーム[]を作れない)
def next_frame?(frames)
  rolls = frames.last # 10フレーム目の配列を rollsに入れる
  # 1-9フレーム目 かつ (ループが始まった瞬間 or strikeを取ったら次のフレームへ or すでに2投投げてたら次のフレームへ)
  !last_frame?(frames) && (frames.empty? || strike?(rolls) || rolls.size == 2)
end

def last_frame?(frames)
  frames.size == 10
end

def strike?(rolls)
  rolls[0] == 10
end

def spare?(rolls)
  !strike?(rolls) && rolls.sum == 10
end

if __FILE__ == $PROGRAM_NAME
  puts calc_score(ARGV[0])
end
