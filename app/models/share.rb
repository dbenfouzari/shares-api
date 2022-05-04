# frozen_string_literal: true

# == Schema Information
#
# Table name: shares
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  medium_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_shares_on_medium_id  (medium_id)
#  index_shares_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (medium_id => media.id)
#  fk_rails_...  (user_id => users.id)
#
class Share < ApplicationRecord
  include Likeable
  include Commentable

  belongs_to :user
  belongs_to :medium
end
