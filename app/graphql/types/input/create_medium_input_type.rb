module Types
  module Input
    class CreateMediumInputType < Types::BaseInputObject
      argument :title, String, required: true, description: "Medium title"
      argument :description, String, required: false, description: "Medium description"
    end
  end
end
