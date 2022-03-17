require 'swagger_helper'

RSpec.describe 'users', type: :request do
  path '/users' do
    get 'Find all users' do
      tags 'Users'
      produces "application/json"

      response 200, 'successful' do
        schema "$ref" => "#/components/schemas/Users"

        run_test!
      end
    end

    post 'Create a single user' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        "$ref": "#/components/schemas/CreateUserAttributes"
      }

      response 201, 'user created' do
        schema "$ref" => "#/components/schemas/User"

        let(:user) { { first_name: "John", last_name: "Doe", email: "john@doe.com" } }
        run_test!
      end
    end
  end

  path '/users/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :id, in: :path, type: :string

    get 'Get a user by its ID' do
      tags 'Users'
      produces 'application/json'

      response 200, 'successful' do
        schema "$ref" => "#/components/schemas/User"

        let(:id) { User.create!(first_name: "John", last_name: "Doe", email: "john@doe.com").id }
        run_test!
      end
    end

    patch 'Update a user' do
      tags 'Users'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :user, in: :body, schema: {
        '$ref': '#/components/schemas/UpdateUserAttributes'
      }

      response(200, 'successful') do
        schema "$ref" => "#/components/schemas/User"

        let(:id) { User.create!(first_name: "John", last_name: "Doe", email: "john@doe.com").id }
        let(:user) { { first_name: "Jane" } }
        run_test!
      end
    end

    put 'Update a user' do
      tags 'Users'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :user, in: :body, schema: {
        '$ref': '#/components/schemas/UpdateUserAttributes'
      }

      response(200, 'successful') do
        schema "$ref" => "#/components/schemas/User"

        let(:id) { User.create!(first_name: "John", last_name: "Doe", email: "john@doe.com").id }
        let(:user) { { first_name: "Jane" } }
        run_test!
      end
    end
  end
end
