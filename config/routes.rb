Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  post "/graphql", to: "graphql#execute"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  concern :likeable do
    resources :likes, except: [:show, :update]
  end
  concern :commentable do
    resources :comments, except: [:show], concerns: :likeable
  end

  resources :media
  resources :users, except: [:destroy]
  resources :shares, except: [:update], concerns: [:likeable, :commentable]
end
