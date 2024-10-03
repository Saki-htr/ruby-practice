
# 最後の計算
def calc_score(pinfall_text)
  pinfalls = parse_pinfall_text(pinfall_text)
  # スコアをフレームごとの2次元配列に変換する
  frames = [] # これに格納する
  pinfalls.each_with_index do |pinfall, index|
    # 1-9frameは[]の中に入れて、 10frame目は[]をたさず、全部同じ[]に入れる
    frames << [] if next_frame?(frames)
    rolls = frames.last
    rolls << pinfall
  end
  p frames
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

calc_score('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
