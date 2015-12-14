
shared_context :set_spreadsheets do
	let(:was_1_title) { 'existent_spreadsheet_for_tests' }
	let(:was_0_title) { 'nonexistent_spreadsheet_for_tests' }

	before(:example) do
		session.exact_sss(was_1_title).each(&:delete)
		session.create_spreadsheet was_1_title

		session.exact_sss(was_0_title).each(&:delete)
	end
end