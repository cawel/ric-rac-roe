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
	game = session[:game]
	game.play(params[:x], params[:y])
	redirect '/over' if game.over?

	@squares = game.squares
	@message = game.status_message
	haml :game
end

get '/over' do
	game = session[:game]
	@squares = game.squares
	if game.winner.nil?
		@message = "Draw!"
	else
		@message = "Player #{game.winner} won!"
	end
	haml :game
end

get '/about' do
	haml :about
end

def new_game
	game = GameSinatra.new
	session[:game] = game
	@squares = game.squares
end

