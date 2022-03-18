# frozen_string_literal: true

module Mutations
  # Mutation that is used to delete a Share
  class DeleteShare < Mutations::BaseMutation
    description 'Delete a share'

    null true
    argument :id, ID, required: true, description: 'Share ID'

    field :share, Types::ShareType, description: 'Deleted share'
    field :errors, [String], null: false, description: 'Errors during share creation'

    def resolve(id:)
      share = Share.find(id)

      if share.delete
        { share:, errors: [] }
      else
        { share: nil, errors: share.errors.full_messages }
      end
    end
  end
end
