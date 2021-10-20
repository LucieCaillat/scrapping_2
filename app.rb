require 'bundler'
Bundler.require
require 'open-uri' 
require 'dotenv'
Dotenv.load('.env')

require_relative 'lib/scrapper'


array_val_d_oise_mairie = Scapper.new("http://annuaire-des-mairies.com/val-d-oise.html")
puts array_val_d_oise_mairie.perform