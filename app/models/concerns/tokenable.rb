module Tokenable

  # 讓Ruby認得Rails : Model Concern
  extend ActiveSupport::Concern

  included do
    before_create :generate_token
  end

  def generate_token
    self.token = SecureRandom.uuid
  end
end
