class Mutations::CreateShare < Mutations::BaseMutation
  description "Create a share"

  null true
  argument :medium_id, ID, required: true, description: "Medium ID"
  argument :user_id, ID, required: true, description: "User ID"

  field :share, Types::ShareType, description: "Created share"
  field :errors, [String], null: false, description: "Errors during share creation"

  def resolve(medium_id:, user_id:)
    share = Share.new(medium_id: medium_id, user_id: user_id)
    if share.save
      {
        share: share,
        errors: [],
      }
    else
      {
        share: nil,
        errors: share.errors.full_messages,
      }
    end
  end
end
