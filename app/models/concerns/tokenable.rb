module Tokenable
	# to make it able to access filters and other
	extend ActiveSupport::Concern

	included do
		before_create :generate_token
	end

	def generate_token
		self.token = SecureRandom.uuid
	end
end