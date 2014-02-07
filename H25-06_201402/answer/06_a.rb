# -*- coding: utf-8 -*-
require "smalruby"

# 課題A: ゲームオーバー
# ボールが画面の外に出てしまったときにゲームオーバーとなるようにします。
# かならずgameover.wavをダウンロードしてから課題に取り組みましょう。

# 画面の幅を 800 に設定する
Window.width = 800

# バウンドの位置
land = 310

# 得点
score = 0

# ボールの速さ
speed = 10

# 課題A-1: ゲームオーバーかどうか
game_over = false

background = Canvas.new
score_board = Canvas.new(height: 20)
wall = Canvas.new(x: 780, y: 50, width: 10, height: 280)
racket = Canvas.new(x: 40, y: 100, width: 10, height: 120)
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
# 自由課題A-2: ↓のどこかを変更してゲームオーバーになったあとはラケットが動かないようにしましょう
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
      # 課題A-2: ボールを消す
      self.x = 50
      self.y = land
      self.visible = false

      # 課題A-3: ゲームオーバー
      if !game_over
        game_over = true

        play(name: "gameover.wav")

        # ラケットを下に移動させることでゲームオーバーを演出しています
        loop do
          racket.y += 10
          if racket.y >= land
            break
          end
        end
      end
      # 自由課題A-1: ↑のifとendの間を変更してゲームオーバーの演出を増やしてみましょう
      # ヒント: まずはラケットが下に落ちた後にラケットを消してみましょう

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
