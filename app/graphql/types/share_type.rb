# frozen_string_literal: true

module Types
  class ShareType < Types::BaseObject
    description "Share"

    field :id, ID, null: false, description: "Share ID"
    field :user, Types::UserType, null: false, description: "User that shared the medium"
    field :medium, Types::MediumType, null: false, description: "Medium shared by the user"
    field :user_id, ID, null: false, description: "ID of user that shared the medium"
    field :medium_id, ID, null: false, description: "ID of medium shared by the user"
    field :likes, [Types::LikeType]

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
