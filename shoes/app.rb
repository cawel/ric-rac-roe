require File.join(File.dirname(__FILE__), 'game_shoes.rb')

Shoes.app(:title => "Ric-rac-roe", :width => 630, :height => 670) do
	background black

	def init_game
		@game = GameShoes.new
		@images = []
		3.times {@images << Array.new(3)}
	end

	init_game

	# elements layout
	@gameplay = stack do
		(0..2).each do |row|
			flow do
				(0..2).each do |col|
					@images[col][row] = image "images/empty.gif", :margin => 5
					@images[col][row].click { on_click(col, row) } 
				end
			end
		end
		@status = para "Let the game begin!", :stroke => white
		#@new_game = button "new game" do
			#new_game
		#end
	end


	### helper methods

	def new_game
		init_game
		@gameplay.clear
		# TODO: how do I redraw my gameplay?
	end


	def on_click x, y
		play(x, y)
		@status.text = @game.status_message
		end_game if @game.over?
	end

	def play x, y
		@game.play(x, y)
		if @game.squares[y][x] == "X"
			@images[x][y].path =  "images/x.gif"
		else
			@images[x][y].path =  "images/o.gif"
		end
		@images[x][y].click {}
	end

	def end_game
		if @game.winner.nil?
			@status.text = "Draw!"
		else
			@status.text = "Player with #{@game.winner}'s won!"
		end

		(0..2).each do |row|
			(0..2).each do |col|
				@images[col][row].click {}
			end
		end
	end

end
