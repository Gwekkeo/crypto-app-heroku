class Crypto < ApplicationRecord
	validates :nom, presence: true
	validates :value, presence: true
end
