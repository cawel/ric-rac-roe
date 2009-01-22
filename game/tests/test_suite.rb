tmp_cd = Dir.pwd

Dir.chdir File.dirname( __FILE__)
files =  Dir["test_*"]
files.delete File.basename(__FILE__)
files.each do |test_file|
	require  test_file
end

Dir.chdir tmp_cd
