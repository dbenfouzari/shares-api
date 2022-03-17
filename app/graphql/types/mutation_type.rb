module Types
  class MutationType < Types::BaseObject
    field :create_medium, mutation: Mutations::CreateMedium
    field :create_user, mutation: Mutations::CreateUser
    field :create_share, mutation: Mutations::CreateShare
    field :delete_share, mutation: Mutations::DeleteShare
  end
end
