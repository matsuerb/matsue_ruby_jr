# coding: utf-8
require "smalruby"
# 画面サイズ
Window.width = 800

# 重力の力
G = 2

# 得点
score = 0

background = Canvas.new
scorebood = Canvas.new
wall = Canvas.new(x: 780, y: 50, width: 50, height: 280)
racket = Canvas.new(x: 40, y: 200, height: 100, width: 10)

# radius: 半径
# color: 色
# canvas: 描画するキャンバス
# land: バウンドの位置（地面のtop - ボールの直径）
# speed: 移動スピード
# power: 跳ねる力
# score: 得点
ball_options = [
  {
    radius: 10,
    color: "white",
    canvas: Canvas.new(x: 50, y: 300, width: 22, height: 22),
    land: 300,
    speed: 20,
    power: 20,
    score: 10,
  },
  {
    radius: 15,
    color: "blue",
    canvas: Canvas.new(x: 100, y: 280, width: 32, height: 32),
    land: 290,
    speed: 25,
    power: 25,
    score: 5,
  },
  {
    radius: 20,
    color: "green",
    canvas: Canvas.new(x: 150, y: 270, width: 42, height: 42),
    land: 280,
    speed: 30,
    power: 20,
    score: 1,
  }
]

# 背景
background.on(:start) do
  box_fill(left: 0, top: 320, right: Window.width, bottom: 480, color: "yellowgreen")
end

# スコアボード
scorebood.on(:start) do
  box_fill(left: 0, top: 0, right: 500, bottom: 40, color: "black")
  draw_font(x: 0, y: 0, string: "得点 0点です。", size: 20)
end

# 壁
wall.on(:start) do
  box_fill(left: 0 , top: 0, right: 10, bottom: 270, color: "burlywood")
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
  racket.x -= 5
end

racket.on(:key_down, K_RIGHT) do
  racket.x += 5
end


# ボール
ball_options.each do |option|
  option[:canvas].on(:start) do
    #キャンバスにボールを描画
    r = option[:radius]
    circle_fill(x: r, y: r, r: r, color: option[:color])

    # y軸移動の初期値
    power = option[:power]

    # ボールの動き
    loop do
      # x軸の移動
      move option[:speed]

      # y軸の移動
      self.y -= power

      # ボールが地面で跳ねる動き（下まで行ったら初期値に戻す）
      if self.y >= option[:land]
        power = option[:power]
        self.y = option[:land]
      else
        power -= G
      end

      if reach_wall?
        vanish
        break
      end
    end
  end

  # ボールとラケットが当たったときの動き
  option[:canvas].on(:hit, racket) do
    turn
    self.x += 5
    score += option[:score]
    scorebood.box_fill(left: 0, top: 0, right: 500, bottom: 40, color: "black")
    scorebood.draw_font(x: 0, y: 0, string: "得点 #{score}点です。", size: 20)
  end

  # ボールが壁にぶつかったときの動き
  wall.on(:hit, option[:canvas]) do
    option[:canvas].turn
    play(name: "piano_do.wav")
  end
end
