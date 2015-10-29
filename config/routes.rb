Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resource :github_webhook, only: [ :create ]
  resource :heroku_webhook, only: [ :create ]

  namespace :api do
    namespace :v1 do
      get 'unreviewed_commits' => 'unreviewed_commits#index'
    end
  end

  post "/comments/:id/unresolved" => 'comments#unresolved'

  post "/commits/:id/reviewed" => 'commits#reviewed'
  post "/commits/:id/started_review" => 'commits#started_review'
  post "/commits/:id/unreviewed" => 'commits#unreviewed'

  post "/comments/:id/resolved" => 'comments#resolved'
  post "/comments/:id/unresolved" => 'comments#unresolved'

  # All paths should render the same page and then we route in JS.
  get 'commits'  => 'pages#index'
  get 'comments' => 'pages#index'
  get 'settings' => 'pages#index'

  root 'pages#index'
end
