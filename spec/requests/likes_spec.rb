# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'likes', type: :request do
  let(:user) do
    User.create! first_name: 'John', last_name: 'Doe', email: 'john@doe.com'
  end

  let(:likeable) do
    medium = Medium.create! title: 'Sample', medium_type: 'movie'
    share = Share.create! user: user, medium: medium

    share
  end

  path '/{likeableType}/{likeableId}/likes' do
    parameter name: :likeableType, in: :path, schema: {
      '$ref': '#/components/schemas/LikeableType'
    }
    parameter name: :likeableId, in: :path, type: :integer, format: :int64, example: 1

    get 'Find all likes' do
      tags 'Likes'
      produces 'application/json'

      response 200, 'successful' do
        schema '$ref' => '#/components/schemas/Likes'

        let(:likeableId) { likeable.id }
        let(:likeableType) { 'shares' }

        run_test!
      end
    end

    post 'Create a single like' do
      tags 'Likes'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :like, in: :body, schema: {
        '$ref': '#/components/schemas/CreateLikeAttributes'
      }

      response 201, 'like created' do
        schema '$ref' => '#/components/schemas/Like'

        let(:likeableId) { likeable.id }
        let(:likeableType) { 'shares' }
        let(:like) { { like: { user_id: user.id } } }
        run_test!
      end
    end
  end

  path '/{likeableType}/{likeableId}/likes/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :id, in: :path, type: :string
    parameter name: :likeableType, in: :path, schema: {
      '$ref': '#/components/schemas/LikeableType'
    }
    parameter name: :likeableId, in: :path, type: :integer, format: :int64, example: 1

    delete 'Delete a like given its ID' do
      tags 'Likes'

      response 204, 'successful' do
        let(:likeableId) { likeable.id }
        let(:likeableType) { 'shares' }
        let(:id) { Like.create(user_id: user.id, likable: likeable).id }

        run_test!
      end
    end
  end
end
