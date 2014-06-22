Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resource :github_webhook, only: [ :create ]
  resource :heroku_webhook, only: [ :create ]

  post "/commits/:id/reviewed" => 'commits#reviewed'
  post "/commits/:id/started_review" => 'commits#started_review'
  delete "/commits/:id/unreviewed" => 'commits#unreviewed'

  # All paths should render the same page and then we route in JS.
  get 'commits'  => 'pages#index'
  get 'comments' => 'pages#index'
  get 'settings' => 'pages#index'

  root 'pages#index'
end
