module GoogleDrive
	module AuthenticationHelper

		# private
		def self.set_auth client_id, client_secret
			auth = Google::APIClient.new({application_name: 'Db To Googlesheet'}).authorization
			auth.client_id = client_id
			auth.client_secret = client_secret

			auth.scope =
				"https://www.googleapis.com/auth/drive " +
				"https://spreadsheets.google.com/feeds/"
			auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"

			auth
		end
	end
end