require 'swagger_helper'

RSpec.describe 'media', type: :request do
  path '/media' do
    get 'Find all media' do
      tags 'Media'
      produces "application/json"

      response 200, 'successful' do
        schema "$ref" => "#/components/schemas/Media"

        run_test!
      end
    end

    post 'Create a single medium' do
      tags 'Media'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :medium, in: :body, schema: {
        "$ref": "#/components/schemas/CreateMediumAttributes"
      }

      response 201, 'medium created' do
        schema "$ref" => "#/components/schemas/Medium"

        let(:medium) { { title: "Sample", medium_type: "movie" } }
        run_test!
      end
    end
  end

  path '/media/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :id, in: :path, type: :string

    get 'Get a medium by its ID' do
      tags 'Media'
      produces 'application/json'

      response 200, 'successful' do
        schema "$ref" => "#/components/schemas/Medium"

        let(:id) { Medium.create!(title: "Sample", medium_type: "movie").id }
        run_test!
      end
    end

    patch 'Update a medium' do
      tags 'Media'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :medium, in: :body, schema: {
        '$ref': '#/components/schemas/UpdateMediumAttributes'
      }

      response(200, 'successful') do
        schema "$ref" => "#/components/schemas/Medium"

        let(:id) { Medium.create!(title: "Sample", medium_type: "movie").id }
        let(:medium) { { title: "New title", medium_type: "movie" } }
        run_test!
      end
    end

    put 'Update a medium' do
      tags 'Media'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :medium, in: :body, schema: {
        '$ref': '#/components/schemas/UpdateMediumAttributes'
      }

      response(200, 'successful') do
        schema "$ref" => "#/components/schemas/Medium"

        let(:id) { Medium.create!(title: "Medium title", medium_type: "movie").id }
        let(:medium) { { title: "New title", medium_type: "movie" } }
        run_test!
      end
    end

    delete "Delete a medium given its ID" do
      tags 'Media'

      response 204, 'successful' do
        let(:id) { Medium.create!(title: "Medium title", medium_type: "movie").id }

        run_test!
      end
    end
  end
end
