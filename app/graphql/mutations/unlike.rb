class Mutations::Unlike < Mutations::BaseMutation
  description "Unlike a likeable object"

  null true
  argument :user_id, ID, required: true, description: "User that likes the likeable"
  argument :likeable_id, ID, required: true, description: "The likeable object ID"
  argument :likeable_type, String, required: true, description: "The likeable object type"

  field :like, Types::LikeType, description: "The like"
  field :errors, [String], null: false, description: "Errors during like creation"

  def resolve(user_id:, likeable_id:, likeable_type:)
    like = Like.where(user_id: user_id, likable_id: likeable_id, likable_type: likeable_type).first

    if like&.destroy
      {
        like: like,
        errors: [],
      }
    else
      {
        like: nil,
        errors: like&.errors&.full_messages || [],
      }
    end
  end
end