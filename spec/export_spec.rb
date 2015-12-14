# WARNING: these tests are not isolated, you need to run them all together. because making them isolated would make them run forever.

require 'spec_helper'
require 'helpers/active_record_helper'

RSpec.configure do |c|
	c.include ActiveRecordHelper
end

describe ModelToGooglesheet::Export do

	before(:context){
		ModelToGooglesheet::Railtie.run_initializers
		ModelToGooglesheet.configuration = ModelToGooglesheet::Configuration.new
	}

	include_context :create_session
	include_context :set_spreadsheets

	before(:context) do
		connect_to_db
	end

	#we sacrifice some modularity for speed
	it 'gets every level configs and creates keys in empty worksheet' do
		setup_table(:users)

		ModelToGooglesheet.configure do |config|
			config.client_id     = client_id
			config.client_secret = client_secret
			config.refresh_token = refresh_token + 'wrong one'
		end

		#because User doesn't know about our local vars (like refesh_token)
		User = Class.new ActiveRecord::Base
		User.exportable_to_googlesheet refresh_token: refresh_token, 
				spreadsheet: was_0_title, worksheet: 'wrong one'

		User.create name: 'Cesilia', age: 38
		User.create name: 'Tom',     age: 17

		#appends first record to the list
		User.first.export_to_googlesheet worksheet: 'wow'

		ws = session.exact_ss(was_0_title).worksheet_by_title('wow')

		expect(ws.list.keys).to  eq(['id', 'name', 'age'])
	end

	it ':convert_with Symbol option' do
		User.class_eval do
			def exportize
				{
					name:    name.upcase,
					comment: 'riddle'
				}
			end
		end

		User.last.export_to_googlesheet spreadsheet: was_1_title, worksheet: 'wow', 
			convert_with: :exportize

		ws = session.exact_ss(was_1_title).worksheet_by_title('wow')

		expect(ws.list.keys).to eq(['name', 'comment'])
		expect(ws.list[0].to_a).to eq([["name", "TOM"], ["comment", "riddle"]])
	end

	it ':convert_with Proc option' do
		User.last.export_to_googlesheet spreadsheet: was_0_title, worksheet: 'wow', 
			convert_with: -> (record) { { age: record.age } }

		ws = session.exact_ss(was_0_title).worksheet_by_title('wow')
		expect(ws.list[0].to_a).to eq([["age", "17"]])
	end

	it 'User.export' do
		User.export_to_googlesheet spreadsheet: was_1_title, worksheet: 'wow'
		#make it return ws so that tests are faster?

		ws = session.exact_ss(was_1_title).worksheet_by_title('wow')
		expect(ws.list[0].to_a).to eq([["id", "1"], ["name", "Cesilia"], ["age", "38"]])
	end







end




	



