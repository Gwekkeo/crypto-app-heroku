require 'rubygems'
require 'nokogiri'
require 'open-uri'

class StartScrap
	attr_accessor :addresse_du_site

	def initialize(adresse_site)
		puts "--- Initliase l'adresse du site ---"

		@addresse_du_site = adresse_site
	end


	def perform(nom_crypto_voulu)
		puts "--- Lance le scrapping ---"

		page = Nokogiri::HTML(open(@addresse_du_site))
		hash = {}

		# Le hash chope TOUTE les crypto et leur value
		if page
		    monnaies = page.css('#currencies-all tbody tr')
			monnaies.each{ |x|
				hash_du_price = {} #hash avec la key: 'price' donne la valeur
				hash_du_price['price'] = x.css('td a.price').text

				nom_crypto = x.css('td a.currency-name-container').text
				hash[nom_crypto] = hash_du_price
			}
		end

		# On retourne seulement la crypto demander par l'user
		hash.each do |name, price|
			if name.downcase == nom_crypto_voulu.downcase
				return {name => price["price"]}
			end
		end
		
		puts "*"*10
		puts "Pas de crypto de ce nom"
		raise ArgumentError
	end


	def save(hash_a_enregistrer)
		puts "--- Enregistre le scrap en BD (sqlite3) ---"

		name = hash_a_enregistrer.keys[0]
		val = hash_a_enregistrer.values[0]
		puts "VALEUR VAUT : #{val} -> #{val.class}"

		mon_info = Crypto.new(nom: name, value: val)
		if mon_info.save
			puts "-"*10
			puts "yes :)"
			puts "-"*10
		else
			puts "-"*10
			puts "PROBLEME DE save"
			puts "-"*10
		end
	end

end
