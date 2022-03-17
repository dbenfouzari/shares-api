class Mutations::CreateMedium < Mutations::BaseMutation
  null true
  argument :title, String, required: true, description: "Medium title"
  argument :description, String, required: false, description: "Medium description"

  field :medium, Types::MediumType, description: "Created medium"
  field :errors, [String], null: false, description: "Errors during medium creation"

  def resolve(title:, description: nil)
    medium = Medium.new(title: title, description: description)
    if medium.save
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
