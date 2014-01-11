# -*- coding: utf-8 -*-
require "smalruby"

# 課題1: 画面の幅を 800 に設定する


# バウンドの位置
land = 310

# 得点
score = 0

background = Canvas.new
score_board = Canvas.new
wall = Canvas.new(x: 780, y: 50, width: 10, height: 280)
racket = Canvas.new(x: 40, y: 200, height: 80, width: 10)
ball = Canvas.new(x: 50, y: land, width: 22, height: 22)

# 背景
background.on(:start) do
  box_fill(left: 0, top: land + 10, right: 800, bottom: 480, color: "yellowgreen")
end

# スコアボード
score_board.on(:start) do
  # 課題2: スコアを表示する




end

# 壁
wall.on(:start) do
  box_fill(left: 0 , top: 0, right: 10, bottom: 280, color: "burlywood")
end

# ラケット
racket.on(:start) do
  box_fill(left: 0, top: 0, right: 10, bottom: 80, color: "yellowgreen")
end

# 課題3: ラケットを動かす
















# ボール
ball.on(:start) do
  # ボールを表示
  circle_fill(x: 10, y: 10, r: 10, color: "white")

  # ボールの跳ねる力
  ball_power = 30

  # 重力の大きさ
  gravity_power = 2

  # y軸移動の初期値
  position_y = ball_power

  # ボールの動き
  loop do
    # x軸の移動
    move(10)

    # 課題4: ボールを跳ねさせる
    # y軸の移動


    # ボールの跳ねる動き（下まで行ったら初期値に戻す）







    if x <= 0
      vanish
      break
    end
  end
end

# ボールが壁にぶつかったときの動き
wall.on(:hit, ball) do
  # 課題5: ボールは反射させる



  # 課題6: スコアを上げる

end

# ボールとラケットが当たったときの動き
ball.on(:hit, racket) do
  # 課題7: ボールは反射させる


end
