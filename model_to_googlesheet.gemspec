$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'model_to_googlesheet/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name          = 'model_to_googlesheet'
  s.version       = ModelToGooglesheet::VERSION
  s.authors       = ['Helga Karunus']
  s.email         = ['lakesare@gmail.com']
  s.homepage      = 'https://github.com/lakesare/model_to_googlesheet'
  s.summary       = 'Export your Rails model to Googlesheets'
  s.description   = "A Railtie that allows you to configute model export to your google worksheet with just a few configurations, and will manage export of either a record or a set of records (with customized fields if you feel like it), export in batches (google spreadsheet gets buggy with large sets of data otherwise), creation of spreadsheet or worksheet if either was nonexistent"
  s.license       = 'MIT'

  s.files         = `git ls-files`.split("\n") - ['.gitignore']
  s.require_paths = ['lib']

  s.add_dependency             'rails',        '~>4.2'
  s.add_dependency             'google_drive', '~>1.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec',        '~>3.4'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-rescue'


  s.required_ruby_version = '>= 1.8.6'
end





# 'title-exact': true везде понаставлять


