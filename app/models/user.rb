class User < ApplicationRecord
  has_many :bids

  validates :username, uniqueness: true, presence: true
  validates :address, presence: true

  before_save :set_secret_key

  def set_secret_key
    if self.new_record?
      base_string = Time.now.to_i.to_s
      self.secret_key = Digest::SHA2.hexdigest(base_string)
    end
  end
end
