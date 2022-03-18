# frozen_string_literal: true

module Mutations
  # Mutation that is used to update a Medium
  class UpdateMedium < Mutations::BaseMutation
    description 'Update a medium'

    null false
    argument :id, ID, required: true, description: 'Medium ID'
    argument :title, String, required: false, description: 'Medium title'
    argument :description, String, required: false, description: 'Medium description'

    field :medium, Types::MediumType, description: 'Updated medium'
    field :errors, [String], null: false, description: 'Errors during medium update'

    def resolve(
      id:,
      title: nil,
      description: nil
    )
      medium = Medium.find(id)
      medium.title = title || medium.title
      medium.description = description || medium.description

      if medium.save
        { medium:, errors: [] }
      else
        { medium: nil, errors: medium.errors.full_messages }
      end
    end
  end
end
