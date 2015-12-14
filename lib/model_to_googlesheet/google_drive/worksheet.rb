module GoogleDrive
	class Worksheet

		def export_hash hash
			begin
				self.list.push hash #will raise error if unfamiliar key. faster than making a request everytime asking for present keys.
			rescue GoogleDrive::Error => error #GoogleDrive::Error: Column doesn't exist: "hi"
				if error.message.include? "Column doesn't exist:" 
					old_keys = self.list.keys # then update all keys, because it'll take same amount of time as updating specific keys
					new_keys = (old_keys + hash.keys).uniq 
					self.list.keys = new_keys #we are updating the first row.
					retry
				end
				raise
			end
			
		end

		

	end
end