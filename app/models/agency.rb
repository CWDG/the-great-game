class Agency < ActiveRecord::Base
	attr_accessible :address, :name

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
