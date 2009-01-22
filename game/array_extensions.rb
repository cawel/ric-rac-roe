class Array

	def common_element
		self.inject(self[0]) do |memo, e|
			memo == e ? memo : nil
		end
	end

end
