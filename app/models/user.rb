# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :citext           not null
#  first_name :string           not null
#  last_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
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

    likes.destroy like.id if like
  end
end
