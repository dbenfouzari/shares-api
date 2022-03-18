# frozen_string_literal: true

module Mutations
  # Mutation that is used to create a User
  class CreateUser < Mutations::BaseMutation
    description 'Create a user'

    null true
    argument :first_name, String, required: true, description: 'User first name'
    argument :last_name, String, required: true, description: 'User last name'
    argument :email, String, required: true, description: 'User email'

    field :user, Types::UserType, description: 'Created user'
    field :errors, [String], null: false, description: 'Errors during user creation'

    def resolve(first_name:, last_name:, email:)
      user = User.new(first_name:, last_name:, email:)

      if user.save
        { user:, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
