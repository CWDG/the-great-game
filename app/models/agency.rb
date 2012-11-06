class Agency < ActiveRecord::Base
	has_many :agents, inverse_of: :agency

	attr_accessible :address, :name, :agents

	validates :name, presence: true
	validates :address, presence: true

	before_save :sanitize_address

	def sanitize_address
		extracted = URI.extract(address).first || address
		if extracted =~ /\Ahttp/
			self.address = URI(extracted).to_s
		else
			self.address = URI("http://#{extracted}").to_s
		end
	end

end
