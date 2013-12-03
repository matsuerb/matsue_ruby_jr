# -*- coding: utf-8 -*-
# 電子ピアノをつくろう

require "smalruby"

# ドの鍵盤を作る
key_do = Canvas.new(x: 200, y: 200, width: 30, height: 100)

# (ドの鍵盤) プログラムがはじまった時
key_do.on(:start) do
  # 課題1: (0, 0)-(29, 99)、"white" 色、四角く塗りつぶす




  # 課題2: (0, 0)-(29, 99)、"gray" 色、四角を描く



end

# (ドの鍵盤) クリックしたとき
key_do.on(:click) do |x, y|
  # 課題3: "ドの音" を再生する

end

# レの鍵盤を作る
key_re = Canvas.new(x: 230, y: 200, width: 30, height: 100)

# 課題4: (レの鍵盤) プログラムがはじまった時
key_re
  # (0, 0)-(29, 99)、"white" 色、四角く塗りつぶす


  # (0, 0)-(29, 99)、"gray" 色、四角を描く



# 課題5: (レの鍵盤) クリックしたとき
key_re
  # "レの音" を再生する



# 課題6: ミの鍵盤を作る


# (ミの鍵盤) プログラムがはじまった時

  # (0, 0)-(29, 99)、"white" 色、四角く塗りつぶす


  # (0, 0)-(29, 99)、"gray" 色、四角を描く



# (ミの鍵盤) クリックしたとき

  # "ミの音" を再生する



# 課題7: ファ、ソ、ラ、シ、ドを一度に作成する
['fa'].each.with_index do |name, i|
  # 鍵盤を作る
  key = Canvas.new(x: 290 + i * 30, y: 200, width: 30, height: 100)

  # (鍵盤) プログラムがはじまった時
  key.on(:start) do
    # (0, 0)-(29, 99)、"white" 色、四角く塗りつぶす
    box_fill(x1: 0, y1: 0, x2: 29, y2: 99, color: "white")
    # (0, 0)-(29, 99)、"gray" 色、四角を描く
    box(x1: 0, y1: 0, x2: 29, y2: 99, color: "gray")
  end

  # (鍵盤) クリックしたとき
  key.on(:click) do |x, y|
    # "各音" を再生する
    play(name: "piano_#{name}.wav")
  end
end
