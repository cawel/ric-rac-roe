# tests suite runner
# It takes all tests in current directory (except for this file) and run them

tmp_cd = Dir.pwd

Dir.chdir File.dirname( __FILE__)
files =  Dir["*_test.rb"]
files.delete File.basename(__FILE__)
files.each do |test_file|
	require  test_file
end

Dir.chdir tmp_cd
