module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :media, [MediumType], null: false, description: "List all media", extras: [:lookahead]
    field :medium, MediumType, null: true, description: "Find a medium by ID", extras: [:lookahead] do
      argument :id, ID, description: "Medium ID"
    end

    def media(lookahead:)
      all_selections = lookahead.selections.map(&:name)

      Medium.select(all_selections)
    end

    def medium(id:, lookahead:)
      all_selections = lookahead.selections.map(&:name)

      Medium.select(all_selections).find(id)
    end

    field :users, [UserType], null: false, description: "List all users", extras: [:lookahead]
    field :user, UserType, null: true, description: "Find a user by ID", extras: [:lookahead] do
      argument :id, ID, description: "User ID"
    end

    def users(lookahead:)
      all_selections = lookahead.selections.map(&:name)

      User.select(all_selections)
    end

    def user(id:, lookahead:)
      all_selections = lookahead.selections.map(&:name)

      User.select(all_selections).find(id)
    end
  end
end
