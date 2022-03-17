class Medium < ApplicationRecord
  enum medium_type: {
    book: 'book',
    restaurant: 'restaurant',
    video_game: 'video_game',
    movie: 'movie',
    series: 'series',
  }

  validates :title, presence: true, length: { minimum: 3 }
  validates :medium_type, presence: true, inclusion: { in: medium_types.keys }

  has_many :shares
end
