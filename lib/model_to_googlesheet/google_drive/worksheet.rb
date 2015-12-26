module GoogleDrive
	class Worksheet

		def export_hash hash, update: false, find_by: nil
			update_keys(hash)

			if update #find by :id/:whatever and update if found, else append

				row = row_with_hash hash, find_by: find_by
				row ? row.update(hash) : list.push(hash)

			else #append
				list.push(hash)
			end

		end

		#either returns first row with given condition true, or nil
		def row_with_hash hash, find_by: nil
			row = list.find do |row| #GoogleDrive::ListRow
				row[find_by] == hash[find_by].to_s
			end
		end

		private


			#merge existing keys with the new ones. 
			#(doesn't take additional request, since this request will preload other rows)
			def update_keys hash
				old_keys = self.list.keys 
				new_keys = (old_keys + hash.keys.map(&:to_s)).uniq 
				self.list.keys = new_keys #we are updating the first row.
			end

		

	end
end