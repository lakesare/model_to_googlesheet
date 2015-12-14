
shared_context :create_session do
	let(:client_id) { '274709489501-ekvsdc8cpuh9nrps73h55m29i1kbgtgk.apps.googleusercontent.com' }
	let(:client_secret) { 'hbSi0Q7VWArzLQZ2maJoagdx' }
	let(:refresh_token) { '1/iNO0L49Mnn1EOmhnc5Rn_AEF-6SYlGbAt9cmITdhD4hIgOrJDtdun6zK6XiATCKT' }
	let(:session) {
		GoogleDrive::Session.new_for_gs({
			client_id: client_id, 
			client_secret: client_secret, 
			refresh_token: refresh_token
		})
	}
end









