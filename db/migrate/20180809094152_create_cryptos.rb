class CreateCryptos < ActiveRecord::Migration[5.2]
	def change
		create_table :cryptos do |t|
			t.string :nom
			t.string :value

			t.timestamps
		end
	end
end
