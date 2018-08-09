class StaticPagesController < ApplicationController
  def home
  	if Crypto.last != nil
	  	@dernier_demande = Crypto.last
	  end
  end

  def search
  	puts "\n"*4
  	puts "*"*10
  	puts "\t#{params[:crypto]}"
  	puts "\t#{params[:site]}"

  	mon_scrappeur = StartScrap.new(params[:site])
  	hash_crypto_find = mon_scrappeur.perform(params[:crypto])
  	mon_scrappeur.save(hash_crypto_find)

  	puts "\tOn a trouver : #{hash_crypto_find}"
  	puts "\n"*4

  	redirect_to root_path
  end
end
