# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'shares', type: :request do
  let(:medium) { Medium.create! title: 'Test', medium_type: 'movie' }
  let(:user) { User.create! first_name: 'John', last_name: 'Doe', email: 'john@doe.com' }

  path '/shares' do
    get 'Find all shares' do
      tags 'Shares'
      produces 'application/json'

      response 200, 'successful' do
        schema '$ref' => '#/components/schemas/Shares'

        run_test!
      end
    end

    post 'Create a single share' do
      tags 'Shares'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :share, in: :body, schema: {
        '$ref': '#/components/schemas/CreateShareAttributes'
      }

      response 201, 'share created' do
        schema '$ref' => '#/components/schemas/Share'

        let(:share) { { user_id: user.id, medium_id: medium.id } }
        run_test!
      end
    end
  end

  path '/shares/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :id, in: :path, type: :string

    get 'Get a share by its ID' do
      tags 'Shares'
      produces 'application/json'

      response 200, 'successful' do
        schema '$ref' => '#/components/schemas/Share'

        let(:id) { Share.create!(user_id: user.id, medium_id: medium.id).id }
        run_test!
      end
    end

    delete 'Delete a share given its ID' do
      tags 'Shares'

      response 204, 'successful' do
        let(:id) { Share.create!(user_id: user.id, medium_id: medium.id).id }

        run_test!
      end
    end
  end
end
