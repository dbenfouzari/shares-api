# frozen_string_literal: true

module Types
  # Represent objects that can be liked.
  class LikeableType < Types::BaseUnion
    description 'Objects that can be liked'
    possible_types Types::ShareType, Types::CommentType

    def self.resolve_type(object, _context)
      if object.is_a?(Share)
        Types::ShareType
      else
        Types::CommentType
      end
    end
  end
end
