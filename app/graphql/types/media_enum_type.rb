# frozen_string_literal: true

module Types
  # Represent all media types. It automatically parses it from Medium model
  class MediaEnumType < Types::BaseEnum
    Medium.medium_types.each_key { |medium_type| value(medium_type.upcase, value: medium_type) }
  end
end
