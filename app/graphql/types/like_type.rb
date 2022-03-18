# frozen_string_literal: true

module Types
  class LikeType < Types::BaseObject
    description 'Like'

    field :id, ID, null: false, description: 'Like ID'
    field :user, Types::UserType, null: false, description: 'User that liked the likeable'
    field :likable, Types::LikeableType, null: false, description: 'Entity that has been liked'

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
