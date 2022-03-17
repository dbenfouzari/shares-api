class Mutations::UpdateUser < Mutations::BaseMutation
  description "Update a user"

  null false
  argument :id, ID, required: true, description: "User ID"
  argument :first_name, String, required: false, description: "User first name"
  argument :last_name, String, required: false, description: "User last name"
  argument :email, String, required: false, description: "User email"

  field :user, Types::UserType, description: "Updated user"
  field :errors, [String], null: false, description: "Errors during user update"

  def resolve(id:, first_name: nil, last_name: nil, email: nil)
    user = User.find(id)
    user.first_name = first_name || user.first_name
    user.last_name = last_name || user.last_name
    user.email = email || user.email

    if user.save
      {
        user: user,
        errors: [],
      }
    else
      {
        user: nil,
        errors: user.errors.full_messages,
      }
    end
  end
end
