# frozen_string_literal: true

module Types
  # Represent all GraphQL queries
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :media, [MediumType], null: false, description: 'List all media', extras: [:lookahead] do
      argument :type, Types::MediaEnumType, required: false, description: 'Filter by media type'
    end
    field :medium, MediumType, null: true, description: 'Find a medium by ID',
                               extras: [:lookahead] do
      argument :id, ID, description: 'Medium ID'
    end

    def media(lookahead:, type: nil)
      scope = Medium

      scope = scope.where(medium_type: type) if type

      all_selections = lookahead.selections.map(&:name)

      scope.select(all_selections)
    end

    def medium(id:, lookahead:)
      all_selections = lookahead.selections.map(&:name)

      Medium.select(all_selections).find(id)
    end

    field :users, [UserType], null: false, description: 'List all users', extras: [:lookahead]
    field :user, UserType, null: true, description: 'Find a user by ID', extras: [:lookahead] do
      argument :id, ID, description: 'User ID'
    end

    def users(lookahead:)
      all_selections = lookahead.selections.map(&:name)

      User.select(all_selections)
    end

    def user(id:, lookahead:)
      all_selections = lookahead.selections.map(&:name)

      User.select(all_selections).find(id)
    end

    field :shares, [ShareType], null: false, description: 'List of shares', extras: [:lookahead]
    field :share, ShareType, null: true, description: 'Find a share by ID', extras: [:lookahead] do
      argument :id, ID, description: 'Share ID'
    end

    def shares(lookahead:)
      items = load_shares(lookahead)

      items.all
    end

    def share(id:, lookahead:)
      items = load_shares(lookahead)

      items.find(id)
    end

    private

    def load_shares(lookahead)
      items = Share

      items = items.eager_load([:medium]) if lookahead.selects?(:medium)
      items = items.eager_load([:likes]) if lookahead.selects?(:likes)
      items = items.eager_load([:user]) if lookahead.selects?(:user)

      if lookahead.selects?(:comments)
        items = items.eager_load([comments: :author]) if lookahead.selection(:comments).selects?(:author)
        items = items.eager_load([:comments]) unless lookahead.selection(:comments).selects?(:author)
      end

      items
    end
  end
end
