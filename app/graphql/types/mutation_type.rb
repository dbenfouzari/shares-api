module Types
  class MutationType < Types::BaseObject
    field :create_medium, mutation: Mutations::CreateMedium
    field :create_user, mutation: Mutations::CreateUser
  end
end
