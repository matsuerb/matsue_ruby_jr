# -*- coding: utf-8 -*-
require "smalruby"
# 画面サイズ
width = 800

# ボールの移動スピード
ball_speed = 10

# ボールの跳ねる力
ball_power = 30

# 重力の力
gravity_power = 2

# バウンドの位置
land = 310

# 得点
score = 0

Window.width = 800

canvas = Canvas.new
wall = Canvas.new(x: 780, y: 50, width: 10, height: 280)
racket = Canvas.new(x: 40, y: 200, height: 80, width: 10)
ball = Canvas.new(x: 50, y: land, width: 22, height: 22)
scorebood = Canvas.new

# 背景
canvas.on(:start) do
  box_fill(left: 0, top: land+10, right: width, bottom: 480, color: "yellowgreen")
end

# スコアボード
scorebood.on(:start) do
  box_fill(left: 0, top: 0, right: 500, bottom: 40, color: "black")
  draw_font(x: 0, y: 0, string: "得点 0点です。", size: 20)
end

# 壁
wall.on(:start) do
  box_fill(left: 0 , top: 0, right: 10, bottom: 280, color: "burlywood")
end

# ラケット
racket.on(:start) do
  box_fill(left: 0, top: 0, right: 10, bottom: 80, color: "yellowgreen")
end

racket.on(:key_down, K_UP) do
  self.y -= 5
end

racket.on(:key_down, K_DOWN) do
  self.y += 5
end

racket.on(:key_down, K_LEFT) do
  self.x -= 5
end

racket.on(:key_down, K_RIGHT) do
  self.x += 5
end

#ボール
ball.on(:start) do
  #キャンバスにボールを表示
  circle_fill(x: 10, y: 10, r: 10, color: "white")

  # y軸移動の初期値
  posi_y = ball_power

  # ボールの動き
  loop do
    # x軸の移動
    move ball_speed

    # y軸の移動
    self.y -= posi_y

    # ボールの跳ねる動き（下まで行ったら初期値に戻す）
    if self.y >= land
      posi_y = ball_power
      self.y = land
    else
      posi_y -= gravity_power
    end

    if x <= 0
      vanish
      break
    end
  end
end

# ボールが壁にぶつかったときの動き
wall.on(:hit, ball) do
  ball.turn
  ball.x -= 30

  score += 1
  scorebood.box_fill(left: 0, top: 0, right: 500, bottom: 40, color: "black")
  scorebood.draw_font(x: 0, y: 0, string: "得点 #{score}点です。", size: 20)
end

# ボールとラケットが当たったときの動き
ball.on(:hit, racket) do
  turn
  self.x += 30
end
