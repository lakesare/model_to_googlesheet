###ModelToGooglesheet

###How to install?

		gem 'model_to_googlesheet'

###How to obtain client_id, **client_secret** and **refresh_token**?
https://auth0.com/docs/connections/social/google  

After creation, go to https://console.developers.google.com/apis/library?project=db-to-gs and enable Drive api.  

Choose 'other' as an application type.

Once you get **client_id** and **session_id**, you can get a **refresh_token** with:

`rake model_to_googlesheet:get_refresh_token client_id='274709489501-erfwefrefew14dd43fwf.apps.googleusercontent.com' client_secret='fewcerwfv3432w2r'`

###Configuration
Once you get your **client_id**, **client_secret** and **refresh_token**, you can set them either globally, permodel, or permethod. 
Available options are include:

`client_id`    
`client_secret`  
`refresh_token`  
`spreadsheet`   - title of the spreadheet you'd like to export your data in.  
`worksheet`     - title of the worksheet you'd like to export your data in. if either worksheet or spreadsheet with such titles don't exit, they will be created.   
`convert_with`  - (optional) either symbol of method name in your model or Proc that will return hash (== columns and values to include in a worksheet created).  
`update`        - (optional, only works for separate records) true or false, whether to update rows found by :find_by option. that is, if you have googlesheet rows with unique :name values, you may want to update to set `update: true, find_by: :name`, so that on `user.export_to_googlesheet` gem will try to find a row with a name equal to user's name, and, if successful, update it (or append a new one if row wasn't found). default behavious is to append any record.   
`find_by`       - (optional, only works for separate records, necessary if `update: true`)


##You can put your configuration in */config/initializers*:

		ModelToGooglesheet.configure do |config|
			config.client_id     = client_id
			config.client_secret = client_secret
			config.refresh_token = refresh_token
		end

##You can override that configuration, or add new one options in your model:

		exportable_to_googlesheet refresh_token: refresh_token, 
			spreadsheet: 'My App', worksheet: 'Users'

##And finally you can override it all, or add nothing at all permethod:

		User.last.export_to_googlesheet spreadsheet: 'Another one',
			convert_with: :exportize

provided you have a method 

		def exportize
			{
				name: name.upcase,
				age:  age
			}
		end

in your model. You can also avoid creating new method with proc or lambda:

		convert_with: -> (record) { { name: record.name.upcase, age: record.age } }


If you export a collection of users, gem will recreate your worksheet and export it all to a clean one. If you export one user, gem will add it to the worksheet if it was already created and create a new one (with a spreadsheet if needed) if it couldn't find one, adding record to a newly created one.


##How to delete a record?
You can clear a record with `record.delete_from_googlesheet` method. It requires `:find_by` option to be able to find a record to delete. If spreadsheet or worksheet or record were not found, just returns.

---------
Now works with Mongoid too.


