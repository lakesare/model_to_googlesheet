
module ModelToGooglesheet
	class Railtie < Rails::Railtie

		rake_tasks do
			load 'model_to_googlesheet/tasks/get_refresh_token.rake'
		end

		initializer 'model_to_googlesheet.extend_activerecord' do
			ActiveRecord::Base.extend ModelToGooglesheet::ClassMethods
		end

		config.before_configuration do
			ModelToGooglesheet.configuration = ModelToGooglesheet::Configuration.new
		end

	end
end






