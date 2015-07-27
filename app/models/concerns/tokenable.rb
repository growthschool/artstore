module Tokenable
  def generate_token
    self.token = SecureRandom.uuid
  end
end