$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'model_to_googlesheet'
require 'pry'
require 'pry-rescue'

Dir['./spec/support/*.rb'].each { |file| require file }








# exportable_to_googlesheet 



# User.export_to_googlesheet 'OurUsersInfo' #appends all the users to sheet

# User.find(3).export_to_googlesheet 'OurUsersInfo' #appends one user to sheet



# User.find(3).export_to_googlesheet 'OurUsersInfo' #appends one user to sheet




# # and the in configs allow to set any amount of defaults. no defaults except for fields: defaults to all fields with their column names

# exportable_to_googlesheet name: 'OurUsersInfo', fields: :fields_like_a, client_id:, client_secret:, refresh_token:

# User.export_to_googlesheet #but can override!

# def export_to_googlesheet
# 	...if not hash, to hash acc to :fields||default...
# 	(if hash and :fields on method itself and not by default, WARNING)
# end





	# before(:context) do 
	# 	ActiveRecord::Base.establish_connection(
	# 		:adapter => 'sqlite3',
	# 		:database =>  'spec/test.sqlite3.db'
	# 	)

	# 	ActiveRecord::Base.connection.create_table :users do |t|
	# 		t.string  :name
	# 		t.integer :age
	# 	end

	# 	class User < ActiveRecord::Base
	# 		exportable_to_googlesheet
	# 	end

	# end

