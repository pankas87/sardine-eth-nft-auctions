class User < ApplicationRecord
  has_many :bids

  validates :username, uniqueness: true
  validates :address, presence: true
  validates :secret_key, presence: true

  def before_save
=begin
    - Secret_Key:
      - Automatically generate (before_save hook)
    - SHA-256 of:
      - Current timestamp
    - Configurable salt value
    - Random number
    - Should be unique as well
    - Optional: SHA256 hashed
=end
  end
end
