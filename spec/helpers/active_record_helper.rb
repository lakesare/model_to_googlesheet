module ActiveRecordHelper
	def setup_table name 
		connection = ActiveRecord::Base.connection
		if connection.table_exists? name
			connection.drop_table name
		end
		connection.create_table name do |t|
			if block_given?
				yield t
			else 
				t.string  :name
				t.integer :age
			end
		end
	end

	def connect_to_db
		require 'active_record' #because mongodb is also possible, so let's not put in in gemspec
		ActiveRecord::Base.establish_connection(
			:adapter => 'sqlite3',
			:database =>  'spec/test.sqlite3.db'
		)
	end
end