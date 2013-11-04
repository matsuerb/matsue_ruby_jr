# -*- coding: utf-8 -*-
# 画面をクリックして隠れている車を1台探してみよう

require "smalruby"

# お絵かき
canvas1 = Canvas.new

# 課題8: 車 (最初に隠しておく)
car1 = Character.new(x: 0, y: 148, costume: "car1.png", visible: true)

# (背景) 始まったとき
canvas1.on(:start) do
  # (0, 0)に32の大きさで「画面をクリックして隠れている車を探してね」の
  # 文章を表示する
  draw_font(x: 0, y: 0,
            string: "画面をクリックして隠れている車を探してね",
            size: 32)

  # 課題1: (0, 32)に24の大きさで「ヒント：線の少し上だよ」の文章を表示する




  # 課題2: (0, 200)-(639, 204)の四角をwhite色で塗りつぶす



end
# (背景) クリックしたとき
canvas1.on(:click) do |x, y|
  # お絵かき
  canvas2 = Canvas.new(x: x - 9, y: y - 9, width: 20, height: 20)

  # (お絵かき) 始まったとき
  canvas2.on(:start) do
    # 課題3: (9, 9)、半径9の円をwhite色で塗りつぶす

    # 課題4: 0.5秒待つ

    # (お絵かきを) 取り除く
    vanish
  end
end

# (車) 始まったとき
car1.on(:start) do
  # 課題5: (speed)を(1～5までのランダム)にする

  loop do # ずっと
    # 課題6: (speed)歩動かす

    # 課題7: もし端に着いたら、跳ね返る

  end
end

# (車) クリックしたとき
car1.on(:click) do
  # 課題9: 表示する

end
