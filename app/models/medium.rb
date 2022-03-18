# frozen_string_literal: true

# == Schema Information
#
# Table name: media
#
#  id          :bigint           not null, primary key
#  description :text
#  medium_type :enum
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_media_on_medium_type  (medium_type)
#
class Medium < ApplicationRecord
  enum medium_type: {
    book: 'book',
    restaurant: 'restaurant',
    video_game: 'video_game',
    movie: 'movie',
    series: 'series'
  }

  validates :title, presence: true, length: { minimum: 3 }
  validates :medium_type, presence: true, inclusion: { in: medium_types.keys }

  has_many :shares
end
