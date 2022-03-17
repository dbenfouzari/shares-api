require 'swagger_helper'

RSpec.describe 'media', type: :request do
  path '/media' do
    get 'list media' do
      tags 'Media'
      produces "application/json"

      response 200, 'successful' do
        schema "$ref" => "#/components/schemas/Media"

        run_test!
      end
    end

    post 'create medium' do
      tags 'Media'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :medium, in: :body, schema: {
        "$ref": "#/components/schemas/CreateMediumAttributes"
      }

      response 201, 'medium created' do
        schema "$ref" => "#/components/schemas/Medium"

        let(:medium) { { title: "Medium title" } }
        run_test!
      end
    end
  end

  path '/media/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :id, in: :path, type: :string

    get 'show medium' do
      tags 'Media'
      produces 'application/json'

      response 200, 'successful' do
        schema "$ref" => "#/components/schemas/Medium"

        let(:id) { Medium.create!(title: "Medium title").id }
        run_test!
      end
    end

    patch 'update medium' do
      tags 'Media'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :medium, in: :body, schema: {
        '$ref': '#/components/schemas/UpdateMediumAttributes'
      }

      response(200, 'successful') do
        schema "$ref" => "#/components/schemas/Medium"

        let(:id) { Medium.create!(title: "Medium title").id }
        let(:medium) { { title: "New title" } }
        run_test!
      end
    end

    put('update medium') do
      tags 'Media'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :medium, in: :body, schema: {
        '$ref': '#/components/schemas/UpdateMediumAttributes'
      }

      response(200, 'successful') do
        schema "$ref" => "#/components/schemas/Medium"

        let(:id) { Medium.create!(title: "Medium title").id }
        let(:medium) { { title: "New title" } }
        run_test!
      end
    end

    delete('delete medium') do
      tags 'Media'

      response 204, 'successful' do
        let(:id) { Medium.create!(title: "Medium title").id }

        run_test!
      end
    end
  end
end
