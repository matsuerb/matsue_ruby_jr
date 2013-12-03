# -*- coding: utf-8 -*-
# 電子ピアノをつくろう

require "smalruby"

# ドの鍵盤を作る
key_do = Canvas.new(x: 200, y: 200, width: 30, height: 100)

# (ドの鍵盤) プログラムがはじまった時
key_do.on(:start) do
  # 課題1: (0, 0)-(29, 99)、"white" 色、四角く塗りつぶす
  box_fill(x1: 0, y1: 0,
           x2: 29, y2: 99,
           color: "white")

  # 課題2: (0, 0)-(29, 99)、"gray" 色、四角を描く
  box(x1: 0, y1: 0,
      x2: 29, y2: 99,
      color: "gray")
end

# (ドの鍵盤) クリックしたとき
key_do.on(:click) do |x, y|
  # 課題3: "ドの音" を再生する
  play(name: 'piano_do.wav')
end

# レの鍵盤を作る
key_re = Canvas.new(x: 230, y: 200, width: 30, height: 100)

# 課題4: (レの鍵盤) プログラムがはじまった時
key_re.on(:start) do
  # (0, 0)-(29, 99)、"white" 色、四角く塗りつぶす
  box_fill(x1: 0, y1: 0, x2: 29, y2: 99, color: "white")

  # (0, 0)-(29, 99)、"gray" 色、四角を描く
  box(x1: 0, y1: 0, x2: 29, y2: 99, color: "gray")
end

# 課題5: (レの鍵盤) クリックしたとき
key_re.on(:click) do |x, y|
  # "レの音" を再生する
  play(name: 'piano_re.wav')
end

# 課題6: ミの鍵盤を作る
key_mi = Canvas.new(x: 260, y: 200, width: 30, height: 100)

# (ミの鍵盤) プログラムがはじまった時
key_mi.on(:start) do
  # (0, 0)-(29, 99)、"white" 色、四角く塗りつぶす
  box_fill(x1: 0, y1: 0, x2: 29, y2: 99, color: "white")

  # (0, 0)-(29, 99)、"gray" 色、四角を描く
  box(x1: 0, y1: 0, x2: 29, y2: 99, color: "gray")
end

# (ミの鍵盤) クリックしたとき
key_mi.on(:click) do |x, y|
  # "ミの音" を再生する
  play(name: 'piano_mi.wav')
end

# 課題7: ファ、ソ、ラ、シ、ドを一度に作成する
['fa', 'so', 'ra', 'si', 'do_2'].each.with_index do |name, i|
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
