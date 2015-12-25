
shared_context :create_session do
	let(:client_id) { 'inset yours' }
	let(:client_secret) { 'inset yours' }
	let(:refresh_token) { 'inset yours' }
	let(:session) {
		GoogleDrive::Session.new_for_gs({
			client_id: client_id, 
			client_secret: client_secret, 
			refresh_token: refresh_token
		})
	}
end









