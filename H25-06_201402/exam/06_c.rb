# -*- coding: utf-8 -*-
require "smalruby"

# 課題C: ラケットが小さくなる
# ボールが壁に当たるたびにラケットが小さくなります。

# 画面の幅を 800 に設定する
Window.width = 800

# バウンドの位置
land = 310

# 得点
score = 0

# ボールの速さ
speed = 10

background = Canvas.new
score_board = Canvas.new(height: 20)
wall = Canvas.new(x: 780, y: 50, width: 10, height: 280)
racket = Canvas.new(x: 40, y: 100, height: 120, width: 10)
ball = Canvas.new(x: 50, y: land, width: 22, height: 22)

# 背景
background.on(:start) do
  box_fill(left: 0, top: land + 10, right: Window.width, bottom: Window.height, color: "yellowgreen")
end

# スコアボード
score_board.on(:start) do
  # スコアを表示する
  loop do
    fill(color: "black")
    draw_font(x: 0, y: 0, string: "得点 #{score}点です。", size: 20)
  end
end

# 壁
wall.on(:start) do
  fill(color: "burlywood")
end

# ラケット
racket.on(:start) do
  fill(color: "yellowgreen")
end

# ラケットを動かす
racket.on(:key_down, K_UP) do
  self.y -= 5
end

racket.on(:key_down, K_DOWN) do
  self.y += 5
end

racket.on(:key_down, K_LEFT) do
  self.x -= 15
end

racket.on(:key_down, K_RIGHT) do
  self.x += 5
end

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
    move(speed)

    # ボールを跳ねさせる
    # y軸の移動
    self.y -= position_y

    # ボールの跳ねる動き（下まで行ったら初期値に戻す）
    if self.y >= land
      position_y = ball_power
      self.y = land
    else
      position_y -= gravity_power
    end

    if x <= 0
      vanish
      break
    end
  end
end

# ボールが壁にぶつかったときの動き
ball.on(:hit, wall) do
  # ボールは反射させる
  turn
  self.x = wall.x - 22

  # スコアを上げる
  score += 1

  # スピードを上げる
  if speed < 22
    speed += 1
  end

  # 音を鳴らす
  play(name: 'piano_do.wav')
  play(name: 'piano_mi.wav')
  play(name: 'piano_so.wav')

  # 課題C-2: スコアが5上がるごとにラケットを小さくする

    # 課題C-1: ラケットを小さくする





    # 課題C-4: ラケットが小さくなりすぎたらスピードを元に戻して100点のボーナスを加える






  end # 課題C-3: スコアが5上がるごとにラケットを小さくする

  # 自由課題C-1: スコアが5上がるごとの「5」やボーナスの「100」点を変更して楽しいゲームにしよう
end

# ボールとラケットが当たったときの動き
ball.on(:hit, racket) do
  # ボールは反射させる
  turn
  self.x = racket.x + 22

  # 音を鳴らす
  play(name: 'piano_re.wav')
  play(name: 'piano_fa.wav')
  play(name: 'piano_ra.wav')
end
