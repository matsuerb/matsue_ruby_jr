# -*- coding: utf-8 -*-
# クイズ

require "readline"

QA = [
      [
       '島根県の県庁所在地はどこでしょうか？',
       [
        'a松江市',
        '出雲市',
        '浜田市',
       ],
      ],
      [
       '宍道湖七珍ではないものは？',
       [
        'aたこ',
        'しじみ',
        'すずき',
       ],
      ],
      # 課題1: 問題を増やしましょう。
     ]

score = 0
puts "問題は#{ QA.length }問です。"
QA.each do |q, as|
  # 問題を表示する: p.12

  ans = nil

  # 答えの順番を入れ替える: p.34, ?sort

  as.each_with_index do |a, i|
    if /^a/ =~ a
      ans = i + 1
      # 答えの先頭にある'a'を取り除く

    end
    # 選択肢を表示する: p.15

  end
  loop do
    # キーボードを操作して答えを入力する

    if ans == i.to_i
      # "正解"を表示する: p.12

      # 課題2: 得点(score)を増やしましょう: ?変数がp.14、四則演算ならp.17
      break
    else
      # "はずれ"を表示する: p.12

      # 課題4: 得点(score)を減らしましょう: ?変数がp.14、四則演算ならp.17
    end
  end
end
# 課題3: 得点(score)を表示しましょう: p.15

puts "returnまたはenterキーで終了します。"
gets
