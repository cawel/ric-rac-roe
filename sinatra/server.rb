require 'rubygems'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'game_sinatra.rb')

enable :sessions

get '/' do
	haml :index
end

get '/new' do
	new_game
	@message = "Let the game begin!"
	haml :game
end

post '/play' do 
	set_session_data
	@game.play(params[:x], params[:y])
	redirect '/over' if @game.over?

	@message = @game.status_message
	haml :game
end

get '/over' do
	end_game
	@message = @game.winner.nil? ? "Draw!" : "Player #{@game.winner} won!"
	haml :game
end

get '/about' do
	haml :about
end


### helper methods

def new_game
	 session[:game] = GameSinatra.new
	 @squares = session[:game].squares
end

def end_game
	set_session_data
	@squares.each_with_index do |row, y| 
		row.each_with_index { |square, x| @squares[y][x] = '&nbsp;' if square.nil? }
	end
end

def set_session_data
	@game = session[:game]
	@squares = @game.squares
end
