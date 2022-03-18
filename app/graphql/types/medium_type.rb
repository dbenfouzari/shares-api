# frozen_string_literal: true

module Types
  class MediumType < Types::BaseObject
    description 'A medium is an entity that can be shared by users'

    field :id, ID, null: false, description: 'Medium ID'
    field :title, String, null: false, description: 'Medium title'
    field :description, String, null: true, description: 'Medium description'
    field :medium_type, Types::MediaEnumType, null: false, description: 'Medium type'

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
