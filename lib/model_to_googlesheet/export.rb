# list Provides access to cells using column names, assuming the first row ALREADY contains column names.
# keys() --- Column names i.e. the contents of the first row. Duplicates are removed.
# keys=(ary) --- Updates column names i.e. the contents of the first row.


# ws.list      
# ws.list.keys --- waits, but caches
# ws.list.push 

module ModelToGooglesheet
	module Export

		def self.included(base)
			base.extend ClassMethods
		end


		def export_to_googlesheet permethod_options={}
			options = Configuration.merge_configs permethod_options, model_to_googlesheet_configuration

			session = GoogleDrive::Session.new_for_gs({
				client_id: options[:client_id], 
				client_secret: options[:client_secret], 
				refresh_token: options[:refresh_token]
			})
			ss = session.get_or_create_ss options[:spreadsheet]
			ws = ss.get_or_create_ws options[:worksheet]

			record_hash = self.get_exportable_hash options[:convert_with]

			ws.export_hash record_hash, 
				update: options[:update], find_by: options[:find_by]

			ws.save
		end

		def delete_from_googlesheet permethod_options={}
			options = Configuration.merge_configs permethod_options, model_to_googlesheet_configuration

			session = GoogleDrive::Session.new_for_gs({
				client_id: options[:client_id], 
				client_secret: options[:client_secret], 
				refresh_token: options[:refresh_token]
			})
			ss = session.exact_ss options[:spreadsheet]
			return unless ss
			ws = ss.worksheet_by_title options[:worksheet]
			return unless ws

			record_hash = get_exportable_hash options[:convert_with]

			row = ws.row_with_hash record_hash, find_by: options[:find_by]
			return unless row

			row.clear 
			ws.save
		end

		def get_exportable_hash convert_with
			ActiveSupport::HashWithIndifferentAccess.new(
				case convert_with 
				when nil 
					attributes
				when Symbol 
					self.send convert_with
				when Proc
					convert_with.call self
				end
			)
		end




		module ClassMethods
			BATCH_SIZE = 500 #google drive has trouble with saving about 2000 of rows right away, so we're saving them in batches. we may raise batch size up to about 1000.

			def export_to_googlesheet permethod_options={}
				options = Configuration.merge_configs permethod_options, model_to_googlesheet_configuration
				
				session = GoogleDrive::Session.new_for_gs({
					client_id: options[:client_id], 
					client_secret: options[:client_secret], 
					refresh_token: options[:refresh_token]
				})
				ss = session.get_or_create_ss options[:spreadsheet]
				ws = ss.create_or_recreate_ws options[:worksheet]

				amount_of_batches_to_skip = self.count/BATCH_SIZE
				(0..amount_of_batches_to_skip).each do |skip_n_batches|
					records = limit(BATCH_SIZE).offset(skip_n_batches*BATCH_SIZE)

					-> {
						records.each do |record|
							record_hash = record.get_exportable_hash options[:convert_with]
							ws.export_hash record_hash, update: false, find_by: false
						end
						ws.save
					}.rescue(2){
						# get a new session token (expires in about 1hr)
						# if this isn't why we failed, refreshing token 
						# is still useful.
						session = GoogleDrive::Session.new_for_gs({
							client_id: options[:client_id], 
							client_secret: options[:client_secret], 
							refresh_token: options[:refresh_token]
						})
						ss = session.exact_ss options[:spreadsheet]
						ws = ss.worksheet_by_title options[:worksheet]
					}


				end


			end



		end








	end
end

