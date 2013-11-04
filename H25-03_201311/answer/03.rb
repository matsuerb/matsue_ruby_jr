# -*- coding: utf-8 -*-
# 画面をクリックして隠れている車を1台探してみよう

require "smalruby"

# お絵かき
canvas1 = Canvas.new

# 課題8: 車 (最初に隠しておく)
car1 = Character.new(x: 0, y: 148, costume: "car1.png", visible: false)

# (背景) 始まったとき
canvas1.on(:start) do
  # (0, 0)に32の大きさで「画面をクリックして隠れている車を探してね」の
  # 文章を表示する
  draw_font(x: 0, y: 0,
            string: "画面をクリックして隠れている車を探してね",
            size: 32)

  # 課題1: (0, 32)に24の大きさで「ヒント：線の少し上だよ」の文章を表示する
  draw_font(x: 0, y: 32,
            string: "ヒント：線の少し上だよ",
            size: 24)

  # 課題2: (0, 200)-(639, 204)の四角をwhite色で塗りつぶす
  box_fill(x1: 0, y1: 200,
           x2: 639, y2: 204,
           color: "white")
end
# (背景) クリックしたとき
canvas1.on(:click) do |x, y|
  # お絵かき
  canvas2 = Canvas.new(x: x - 9, y: y - 9, width: 20, height: 20)

  # (お絵かき) 始まったとき
  canvas2.on(:start) do
    # 課題3: (9, 9)、半径9の円をwhite色で塗りつぶす
    circle_fill(x: 9, y: 9, r: 9, color: "white")
    # 課題4: 0.5秒待つ
    sleep(0.5)
    # (お絵かきを) 取り除く
    vanish
  end
end

# (車) 始まったとき
car1.on(:start) do
  # 課題5: (speed)を(1～5までのランダム)にする
  speed = rand(1..5)
  loop do # ずっと
    # 課題6: (speed)歩動かす
    move(speed)
    # 課題7: もし端に着いたら、跳ね返る
    turn_if_reach_wall
  end
end

# (車) クリックしたとき
car1.on(:click) do
  # 課題9: 表示する
  self.visible = true
end
