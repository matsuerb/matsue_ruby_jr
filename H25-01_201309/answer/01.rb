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
      [
       '松江フォーゲルパークの「フォーゲル」とは何を意味する？',
       [
        'a鳥',
        '花',
        '湖',
       ],
      ],
     ]

score = 0
puts "問題は#{ QA.length }問です。"
QA.each do |q, as|
  # 問題を表示する
  puts q
  ans = nil
  # 答えの順番を入れ替える
  as = as.sort { rand(3) - 1 }
  as.each_with_index do |a, i|
    if /^a/ =~ a
      ans = i + 1
      # 答えの先頭にある'a'を取り除く
      a.sub!(/^a/, '')
    end
    # 選択肢を表示する
    puts "#{ i + 1 }: #{ a }"
  end
  loop do
    # キーボードを操作して答えを入力する
    i = Readline.readline('答えは？')
    if ans == i.to_i
      # "正解"を表示する
      puts "正解"
      # 課題2: 得点(score)を増やしましょう
      score += 10
      break
    else
      # "はずれ"を表示する
      puts "はずれ"
      # 課題4: 得点(score)を減らしましょう
      score -= 5
    end
  end
end
# 課題3: 得点(score)を表示しましょう
puts "得点は#{ score }点でした。"
puts "returnまたはenterキーで終了します。"
gets
