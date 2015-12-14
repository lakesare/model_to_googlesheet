require 'spec_helper'

describe GoogleDrive::Session do

	include_context :create_session
	include_context :set_spreadsheets

	it 'fetches existent spreadsheet' do
		session.get_or_create_ss was_1_title
		i = session.exact_sss(was_1_title).size 

		expect(i).to eq(1)
	end

	it "creates spreadsheet if can't fetch it" do
		session.get_or_create_ss was_0_title
		i = session.exact_sss(was_0_title).size

		expect(i).to eq(1)
	end

	it "creates worksheet and spreadsheet if can't fetch both" do
		spreadsheet = session.get_or_create_ss was_0_title
		worksheet = spreadsheet.get_or_create_ws 'worksheety'

		expect(spreadsheet.title).to eq(was_0_title)
		expect(worksheet.title).to eq('worksheety')
	end

	it "creates worksheet if only spreadsheet exists" do
		spreadsheet = session.get_or_create_ss was_1_title
		worksheet = spreadsheet.get_or_create_ws 'worksheety'
			
		expect(worksheet.title).to eq('worksheety')
	end

	it 'recreates worksheet' do
		spreadsheet = session.get_or_create_ss was_1_title
		worksheet = spreadsheet.get_or_create_ws 'worksheety'

		worksheet[1, 1] = 'filled in'
		worksheet.save

		new_worksheet = spreadsheet.create_or_recreate_ws 'filled in'
		expect(new_worksheet[1, 1]).to eq('')
	end

end

