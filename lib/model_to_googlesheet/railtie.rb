
module ModelToGooglesheet
	class Railtie < Rails::Railtie

		rake_tasks do
			load 'model_to_googlesheet/tasks/get_refresh_token.rake'
		end

		initializer 'model_to_googlesheet.extend_db_mapper' do
			# we may use ActiveRecord::Base.extend ModelToGooglesheet::ClassMethods, but
			# let's extend Object
			# for Mongoid eg, and maybe some other db mappers
			Object.extend ModelToGooglesheet::ClassMethods 
		end

		config.before_configuration do
			ModelToGooglesheet.configuration = ModelToGooglesheet::Configuration.new
		end

	end
end






