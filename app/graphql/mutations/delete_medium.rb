class Mutations::DeleteMedium < Mutations::BaseMutation
  description "Delete a medium"

  null true
  argument :id, ID, required: true, description: "Medium ID"

  field :medium, Types::MediumType, description: "Deleted medium"
  field :errors, [String], null: false, description: "Errors during medium creation"

  def resolve(id:)
    medium = Medium.find(id)

    if medium.delete
      {
        medium: medium,
        errors: [],
      }
    else
      {
        medium: nil,
        errors: medium.errors.full_messages,
      }
    end
  end
end
