require 'gosu'

class WhakaMole < Gosu::Window
	def initialize
		super 800, 600
		self.caption = "Wake 'a Mole"

    	@image = Gosu::Image.new("images/mole.png")
	end
end

window = WhakaMole.new
window.show