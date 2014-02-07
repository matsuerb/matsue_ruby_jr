# -*- coding: utf-8 -*-
require "smalruby"

INITIAL_RACKET_LENGTH = 80
MIN_RACKET_LENGTH = 10
DECREMENT_PER_ONCE = 5

# 課題1: 画面の幅を 800 に設定する
Window.width = 800

# バウンドの位置
land1 = 310
land2 = 310
land3 = 310

# 得点
score = 0

# 残り
nokori = 2

# ゲームエンド
game_end = false

# ラケットの設定
racket_position  = [40, 200]              # ラケットの初期位置 [x, y]
racket_height    = INITIAL_RACKET_LENGTH  # 高さ
racket_width     = 10                     # 幅

background = Canvas.new
score_board = Canvas.new
remaining_display = Canvas.new(x: 0, y: 450, width: 300, height: 80)
wall = Canvas.new(x: 780, y: 50, width: 10, height: 280)
racket = Canvas.new(x: racket_position[0], y: racket_position[1], height: racket_height, width: racket_width)
ball1 = Canvas.new(x: 50, y: land1, width: 22, height: 22)
ball2 = Canvas.new(x: 100, y: land2, width: 26, height: 26)
ball3 = Canvas.new(x: 150, y: land3, width: 30, height: 30)

# 背景
background.on(:start) do
  box_fill(left: 0, top: land1 + 10, right: 800, bottom: 480, color: "yellowgreen")
end

# スコアボード
score_board.on(:start) do
  # 課題2: スコアを表示する
  loop do
    box_fill(left: 0, top: 0, right: 500, bottom: 40, color: "black")
    draw_font(x: 0, y: 0, string: "得点 #{score}点です。", size: 20)
  end
end

# 残り
remaining_display.on(:start) do
  loop do
    box_fill(left: 0, top: 0, right: 500, bottom: 40, color: "black")
    if nokori > 0
      comment = "あと #{nokori}回です。"
    else
      comment = "終わりです。"
    end
    draw_font(x: 0, y: 0, string: comment, size: 20)
  end
end

# 壁
wall.on(:start) do
  box_fill(left: 0 , top: 0, right: 10, bottom: 280, color: "burlywood")
end

# ラケット
racket.on(:start) do
  box_fill(left: 0, top: 0, right: racket_width, bottom: racket_height, color: "yellowgreen")
end

# 課題3: ラケットを動かす
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

racket.on(:key_down, K_SPACE) do
  if game_end
    ball1.turn
    ball1.x = 50
    ball1.y = land1
    ball1.visible = true
    ball2.turn
    ball2.x = 100
    ball2.y = land2
    ball2.visible = true
    ball3.turn
    ball3.x = 150
    ball3.y = land3
    ball3.visible = true
    racket.x = 40
    racket.y = 200
    racket_height = INITIAL_RACKET_LENGTH
    score = 0
    nokori = 2
    game_end = false
  end
end

# ボール
ball1.on(:start) do
  # ボールを表示
  circle_fill(x: 10, y: 10, r: 10, color: "white")

  # ボールの跳ねる力
  ball_power1 = 30

  # 重力の大きさ
  gravity_power1 = 2

  # y軸移動の初期値
  position_y1 = ball_power1

  # ボールの動き
  loop do
    # x軸の移動
    move(10)

    # 課題4: ボールを跳ねさせる
    # y軸の移動
    self.y -= position_y1

    # ボールの跳ねる動き（下まで行ったら初期値に戻す）
    if self.y >= land1
      position_y1 = ball_power1
      self.y = land1
    else
      position_y1 -= gravity_power1
    end

    if x <= 0
      if nokori > 1
        turn
        ball1.x += racket.x + 10
        ball1.y += racket.y
        nokori -= 1
      else
        nokori -= 1

        # 例題： リトライできる
        ball1.x = 0
        ball1.y = 0
        ball1.visible = false

        # 例題： ゲームオーバーをつくる
        #-> vanish
        if game_end == false
          play(name: "gameover.wav")
          loop do
          racket.y += 10
          if racket.y > 400
        #-->    racket.vanish
            break
          end
         end
        end
        #--> break

        game_end = true
      end
    end
  end
end

ball2.on(:start) do
  circle_fill(x: 12, y: 12, r: 12, color: "yellow")

  ball_power2 = 28

  gravity_power2 = 2

  position_y2 = ball_power2

  loop do
    move(12)

    self.y -= position_y2

    if self.y >= land2
      position_y2 = ball_power2
      self.y = land2
    else
      position_y2 -= gravity_power2
    end

    if x <= 0
      if nokori > 1
        turn
        ball2.x += racket.x + 10
        ball2.y += racket.y
        nokori -= 1
      else
        nokori -= 1

        ball2.x = 0
        ball2.y = 0
        ball2.visible = false

        if game_end == false
          play(name: "gameover.wav")
          loop do
          racket.y += 10
          if racket.y > 400
            break
          end
         end
        end

        game_end = true
      end
    end
  end
end

ball3.on(:start) do
  circle_fill(x: 14, y: 14, r: 14, color: "orange")

  ball_power3 = 26

  gravity_power3 = 2

  position_y3 = ball_power3

  loop do
    move(14)

    self.y -= position_y3

    if self.y >= land3
      position_y3 = ball_power3
      self.y = land3
    else
      position_y3 -= gravity_power3
    end

    if x <= 0
      if nokori > 1
        turn
        ball3.x += racket.x + 10
        ball3.y += racket.y
        nokori -= 1
      else
        nokori -= 1

        ball3.x = 0
        ball3.y = 0
        ball3.visible = false

        if game_end == false
          play(name: "gameover.wav")
          loop do
          racket.y += 10
          if racket.y > 400
            break
          end
         end
        end

        game_end = true
      end
    end
  end
end

# ボールが壁にぶつかったときの動き
wall.on(:hit, ball1) do
  # 課題5: ボールは反射させる
  ball1.turn
  ball1.x -= 30

  # 課題6: スコアを上げる
  score += 1

  # 例題: ラケットのサイズを変える
  # ここから -->
  # ラケットを消す
  racket.vanish

  # ラケットを小さくして作りなおす
  if (racket_height - DECREMENT_PER_ONCE) >= MIN_RACKET_LENGTH
    racket_height -= DECREMENT_PER_ONCE
  end
  racket = Canvas.new(x: racket.x, y: racket.y, height: racket_height, width: racket_width)

  racket.on(:start) do
    box_fill(left: 0, top: 0, right: racket_width, bottom: racket_height, color: "yellowgreen")
  end

  # 課題3: ラケットを動かす
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

  racket.on(:key_down, K_SPACE) do
    if game_end
      ball1.turn
      ball1.x = 50
      ball1.y = land1
      ball1.visible = true
      ball2.turn
      ball2.x = 100
      ball2.y = land2
      ball2.visible = true
      ball3.turn
      ball3.x = 150
      ball3.y = land3
      ball3.visible = true
      racket.x = 40
      racket.y = 200
      score = 0
      nokori = 2
      game_end = false
    end
  end

  # ボールとラケットが当たったときの動き
  ball1.on(:hit, racket) do
    # 課題7: ボールは反射させる
    turn
    self.x += 30
  end

  ball2.on(:hit, racket) do
    turn
    self.x += 30
  end

  ball3.on(:hit, racket) do
    turn
    self.x += 30
  end
  # <-- ここまで
end

wall.on(:hit, ball2) do
  ball2.turn
  ball2.x -= 30

  score += 1
end

wall.on(:hit, ball3) do
  ball3.turn
  ball3.x -= 30

  score += 1
end

# ボールとラケットが当たったときの動き
ball1.on(:hit, racket) do
  # 課題7: ボールは反射させる
  turn
  self.x += 30
end

ball2.on(:hit, racket) do
  turn
  self.x += 30
end

ball3.on(:hit, racket) do
  turn
  self.x += 30
end
