# -*- coding: utf-8 -*-
require "smalruby"

# 課題B: リトライ
# ボールが画面の外に出てしまったあと、スペースキーを押すとリトライできるようにします。
# また3回失敗したときは得点を0に戻します。

# 画面の幅を 800 に設定する
Window.width = 800

# バウンドの位置
land = 310

# 得点
score = 0

# ボールの速さ
speed = 10

# 課題B-4: 残り
nokori = 3

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
# 自由課題B-1: ↓のどこかを変更して残りのボールの数を表示してみよう
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
  self.x -= 5
end

racket.on(:key_down, K_RIGHT) do
  self.x += 5
end

# 課題B-2: スペースキーが押されるまで待つ
space = false
ball.on(:key_push, K_SPACE) do
  space = true
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
      # 課題B-1: ボールを最初の位置に戻す
      self.x = 50
      self.y = land
      turn

      # 課題B-3: スペースキーが押されるまで待つ
      space = false
      loop do
        if space
          break
        end
      end

      # 課題B-5: 残りを減らす
      nokori -= 1

      # 課題B-6: 得点を0にする
      if nokori == 0
        nokori = 3
        score = 0
      end
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
