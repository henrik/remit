Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resource :github_webhook, only: [ :create ]

  post "/commits/:id/reviewed" => 'commits#reviewed'
  delete "/commits/:id/unreviewed" => 'commits#unreviewed'

  root 'pages#index'

  # Catch-all since we don't use hashbang URLs; all paths should
  # render the same page and then we route in JS.
  get '*path' => 'pages#index'
end
