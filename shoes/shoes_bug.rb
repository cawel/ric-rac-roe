# I stumbled upon this bug in shoes:
#
# it is not possible to rename a button's text
# the button size is changed to adapt to the new text
# but the text itself isn't changed :(
# 
# Here is some code to prove it:
Shoes.app do
	@button = nil
	stack do
		@button = button "initial text" do
			@button.style(:text => "text changed to something else ")
			alert @button.style.inspect
		end
	end
end
