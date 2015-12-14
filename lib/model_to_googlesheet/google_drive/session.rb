require_relative 'authentication_helper'
module GoogleDrive
	class Session

		def self.new_for_gs client_id:, client_secret:, refresh_token:
			auth = GoogleDrive::AuthenticationHelper.set_auth client_id, client_secret

			auth.refresh_token = refresh_token
			auth.fetch_access_token!
			@session = login_with_oauth(auth.access_token) 
		end

		def get_or_create_ss title
			ss = exact_ss title
			ss ||= create_spreadsheet(title)
		end

		#spreadsheets(title:) returns trashed files too. 
		#gs doesn't allow to create worksheets with the same title in one spreadsheet
		#and it doesn't trash ws-s
		def exact_ss title
			exact_sss(title).first
		end
		def exact_sss title
			spreadsheets(title: title, 'title-exact': true).select { |ss| !ss.labels.trashed }
		end



	end
end
