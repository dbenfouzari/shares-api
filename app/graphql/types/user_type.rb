# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    description "User"

    field :id, ID, null: false, description: "User ID"
    field :first_name, String, null: false, description: "User first name"
    field :last_name, String, null: false, description: "User last name"
    field :email, String, null: false, description: "User email"

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
