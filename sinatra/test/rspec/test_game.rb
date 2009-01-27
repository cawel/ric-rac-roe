require File.join(File.dirname(__FILE__), '../../server.rb')
require 'rubygems'
require 'sinatra/test/rspec'

describe 'Game logic' do

	before(:each) do
		#needed so that the Sinatra's session middleware does not overwrite 
		#my session data (using 'rack.session') in my test
		disable :sessions 

		@session_game_mock = mock('session_game')
	end

	it 'should be able to play in 0,0' do
		@session_game_mock.should_receive(:squares).and_return([])
		@session_game_mock.should_receive(:play).with('0', '0')
		@session_game_mock.should_receive(:over?)
		@session_game_mock.should_receive(:status_message)
		post '/play', {:x => 0, :y => 0}, 'rack.session' => { :game => @session_game_mock }
	end

	it 'should redirect to /over when game is over' do
		@session_game_mock.should_receive(:squares).and_return([])
		@session_game_mock.should_receive(:play).with('0', '0')
		@session_game_mock.should_receive(:over?).and_return true
		post '/play', {:x => 0, :y => 0}, 'rack.session' => { :game => @session_game_mock }
		@response['Location'].should == '/over'
	end
	
	it 'should fetch winner when game is over' do
		@session_game_mock.should_receive(:squares).and_return([])
		@session_game_mock.should_receive(:winner)
		get '/over', {}, 'rack.session' => { :game => @session_game_mock }
	end

end
