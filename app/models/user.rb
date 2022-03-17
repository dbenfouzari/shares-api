class User < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :shares
  has_many :media, through: :shares

  def share(medium)
    media << medium
  end
end
