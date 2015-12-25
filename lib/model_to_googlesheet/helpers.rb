# -> { raise 'hi' }.rescue(3) { |m| puts m.backtrace[0] }
# -> { raise 'hi' }.rescue(3) { |m, n| puts "number_of_attempts left: #{n}" }
# p -> { 6 }.rescue(10)
Proc.class_eval do
	def rescue number_of_attempts=0
		@n = number_of_attempts
		begin
			self.call 
		rescue => message
			yield message, @n if block_given?
			@n -= 1
			@n > 0 ? retry : raise
		end
	end
end
