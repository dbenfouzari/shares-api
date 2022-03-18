class Types::LikeableType < Types::BaseUnion
  description "Objects that can be liked"
  possible_types Types::ShareType

  def self.resolve_type(object, context)
    if object.is_a?(Share)
      Types::ShareType
    end
  end
end
