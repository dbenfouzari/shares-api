module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :media, [MediumType], null: false, description: "List all media", extras: [:lookahead] do
      argument :type, Types::MediaEnumType, required: false, description: "Filter by media type"
    end
    field :medium, MediumType, null: true, description: "Find a medium by ID", extras: [:lookahead] do
      argument :id, ID, description: "Medium ID"
    end

    def media(type: nil, lookahead:)
      scope = Medium

      if type
        scope = scope.where(medium_type: type)
      end

      all_selections = lookahead.selections.map(&:name)

      scope.select(all_selections)
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

    field :shares, [ShareType], null: false, description: "List of shares", extras: [:lookahead]
    field :share, ShareType, null: true, description: "Find a share by ID", extras: [:lookahead] do
      argument :id, ID, description: "Share ID"
    end

    def shares(lookahead:)
      items = Share

      if lookahead.selects?(:medium)
        items = items.eager_load([:medium])
      end

      if lookahead.selects?(:user)
        items = items.eager_load([:user])
      end

      items.all
    end

    def share(id:, lookahead:)
      items = Share

      if lookahead.selects?(:medium)
        items = items.eager_load([:medium])
      end

      if lookahead.selects?(:user)
        items = items.eager_load([:user])
      end

      items.find(id)
    end
  end
end
