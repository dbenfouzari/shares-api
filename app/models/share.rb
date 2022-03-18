class Share < ApplicationRecord
  belongs_to :user
  belongs_to :medium

  include Likeable
end
