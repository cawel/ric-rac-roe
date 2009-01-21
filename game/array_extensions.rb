class Array

	def same_elements?
		self.inject(self[0]) do |memo, e|
			memo == e ? memo : nil
		end
	end

end
