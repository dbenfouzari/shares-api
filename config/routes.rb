# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  post '/graphql', to: 'graphql#execute'

  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  concern :likeable do
    resources :likes, except: %i[show update]
  end
  concern :commentable do
    resources :comments, except: [:show], concerns: :likeable
  end

  resources :media
  resources :users, except: [:destroy]
  resources :shares, except: [:update], concerns: %i[likeable commentable]
end
