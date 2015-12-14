module GoogleDrive
	class Spreadsheet

		def get_or_create_ws title
			ws = worksheet_by_title title 
			ws ||= add_worksheet(title)
		end

		# to delete everything in the worksheet, deleting row by row is too slow
		def create_or_recreate_ws title
			if ws = worksheet_by_title(title) 
				ws.delete
			end
			add_worksheet title
		end

	end
end