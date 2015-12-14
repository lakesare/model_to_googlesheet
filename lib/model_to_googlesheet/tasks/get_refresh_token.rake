require 'google/api_client'
require 'google_drive'
require 'model_to_googlesheet/google_drive/authentication_helper'

namespace :model_to_googlesheet do

	# add credentials --- CHOOSE other client
	# use this task manually unless you already know your refresh token
	desc "What's my refresh token?\nrake model_to_googlesheet:get_refresh_token client_id='274709489501-ekvsdc8cpuh9nrps73h55m29i1kbgtgk.apps.googleusercontent.com' client_secret='hbSi0Q7VWArzLQZ2maJoagdx'"
	task :get_refresh_token do
		auth = GoogleDrive::AuthenticationHelper.set_auth ENV['client_id'], ENV['client_secret']
		puts "1. Open this page:\n #{auth.authorization_uri}\n\n"
		print "2. Enter the authorization code shown in the page: "

		auth.code = $stdin.gets.chomp
		auth.fetch_access_token!
		puts "\nYour refresh token is: #{auth.refresh_token}" 
	end

end
 

