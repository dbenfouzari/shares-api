module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable, dependent: :destroy
    has_many :commenters, through: :comments, source: :author, class_name: 'User'
  end
end
