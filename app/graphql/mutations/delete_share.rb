class Mutations::DeleteShare < Mutations::BaseMutation
  description "Delete a share"

  null true
  argument :id, ID, required: true, description: "Share ID"

  field :share, Types::ShareType, description: "Deleted share"
  field :errors, [String], null: false, description: "Errors during share creation"

  def resolve(id:)
    share = Share.find(id)

    if share.delete
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
