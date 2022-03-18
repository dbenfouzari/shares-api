class User < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :shares
  has_many :media, through: :shares

  has_many :likes

  has_many :comments

  def share(medium)
    media << medium
  end

  def like!(likable)
    likes.create! likable:
  end

  def unlike!(likable)
    like = likes.where(likable:).first

    if like
      likes.destroy like.id
    end
  end
end
