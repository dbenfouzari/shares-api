# frozen_string_literal: true

module Types
  class CommentType < Types::BaseObject
    description "A comment between commentable (share for instance) and an author user"

    field :id, ID, null: false, description: "Comment ID"
    field :body, String, null: false, description: "Comment body"
    field :commentable, Types::ShareType, null: false, description: "Commentable"
    field :author, Types::UserType, null: false, description: "Comment author"
    field :author_id, ID, null: false, description: "Comment author ID"
    field :commentable_id, ID, null: false, description: "Commentable ID"
    field :commentable_type, String, null: false, description: "Commentable type"

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
