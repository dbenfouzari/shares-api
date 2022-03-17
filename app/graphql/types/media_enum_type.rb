class Types::MediaEnumType < Types::BaseEnum
  Medium.medium_types.keys.each { |medium_type| value(medium_type.upcase, value: medium_type) }
end
