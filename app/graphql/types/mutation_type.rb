module Types
  class MutationType < Types::BaseObject
    field :create_medium, mutation: Mutations::CreateMedium
    field :update_medium, mutation: Mutations::UpdateMedium
    field :delete_medium, mutation: Mutations::DeleteMedium
    field :create_user, mutation: Mutations::CreateUser
    field :update_user, mutation: Mutations::UpdateUser
    field :create_share, mutation: Mutations::CreateShare
    field :delete_share, mutation: Mutations::DeleteShare
    field :like, mutation: Mutations::Like
    field :unlike, mutation: Mutations::Unlike
  end
end
