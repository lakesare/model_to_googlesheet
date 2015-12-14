require 'active_record'
require 'rails/railtie'
require 'google/api_client'
require 'google_drive'


require 'model_to_googlesheet/google_drive/session'
require 'model_to_googlesheet/google_drive/spreadsheet'
require 'model_to_googlesheet/google_drive/worksheet'

require 'model_to_googlesheet/export'
require 'model_to_googlesheet/railtie'

module ModelToGooglesheet

	module ClassMethods
		def exportable_to_googlesheet options={}
			mattr_accessor :model_to_googlesheet_configuration
			self.model_to_googlesheet_configuration = ModelToGooglesheet.configuration #here we are initializing permodel configuration with perapp configuration

			options.each do |k, v|
				self.model_to_googlesheet_configuration.send("#{k}=", v) 
			end #unfamiliar option will raise an error

			include ModelToGooglesheet::Export
		end
	end

	class << self
		attr_accessor :configuration
	end
	# for config/initializers
	def self.configure
		yield configuration
	end


	class Configuration
		OPTIONS = [ 
			:client_id, :client_secret, :refresh_token,
			:worksheet, :spreadsheet, 
			:convert_with 
		]

		attr_accessor *OPTIONS

		# defaults
		def initialize
			@client_id      = nil
			@client_secret  = nil
			@refresh_token  = nil
			@worksheet      = nil
			@spreadsheet    = nil
			@convert_with   = nil #optional
		end

		def self.merge_configs permethod_options, permodel_configuration
			options = ActiveSupport::HashWithIndifferentAccess.new permethod_options
			ModelToGooglesheet::Configuration::OPTIONS.each do |option_name|
				options[option_name] ||= permodel_configuration.send(option_name)
			end
			options
		end

	end

end





