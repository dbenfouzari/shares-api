# frozen_string_literal: true

module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likable
    has_many :likers, through: :likes, source: :user, class_name: 'User'
  end
end
