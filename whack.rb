require 'gosu'

class WhakaMole < Gosu::Window
	def initialize
		super(800, 600)
		self.caption = "Whak_a_Mole"

    	@image = Gosu::Image.new("images/mole.png")
		@x = 200
		@y = 200
		@width = 100
		@height = 75
		@velocity_x = 5
		@velocity_y = 5
		@visible = 0
		@hammer = Gosu::Image.new("images/hammer.png")
		@hit = 0
		@font = Gosu::Font.new(30)
		@score = 0
		@playing = true
		@start_time = 0
	end

	def draw
		if @visible > 0
			@image.draw(@x - @width / 2, @y - @height / 2, 1)
		end

		@hammer.draw(mouse_x - 25, mouse_y - 39, 1)

		if @hit == 0
			c = Gosu::Color::NONE
		elsif @hit == 1
			c = Gosu::Color::GREEN
		elsif @hit == -1
			c = Gosu::Color::RED
		end
		
		# draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
		Gosu.draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c, z = 0, mode = :default)
		@hit = 0
		@font.draw_text(@score.to_s, 650, 50, 2)
		@font.draw_text(@time_left.to_s, 50, 50, 2)
		unless @playing
			@font.draw_text("Game Over!!!", 300, 300, 3)
			@visible = 20
			@time_left = 0
			@font.draw_text("Press Space Bar To Play Again", 190, 350, 3)
		end
	end

	def update
		if @playing
			@x += @velocity_x
			@y += @velocity_y
			@velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0
			@velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0
			@visible -= 1
			@visible = 30 if @visible < -10 && rand < 0.01
			@time_left = (10 - ((Gosu.milliseconds - @start_time) / 1000))
			@playing = false if @time_left < 0
		end
	end

	def button_down(id)
		if @playing
			if (id == Gosu::MsLeft)
				if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0
					@hit = 1
					@score = @score + 10
				else
					@hit = -1
					@score = @score - 3
				end
			end
		else
			if (id == Gosu::KbSpace)
				@playing = true
				@visible = -10
				@start_time = Gosu.milliseconds
				@score = 0
			end
		end
	end

end

window = WhakaMole.new
window.show
