Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'pages#index'
  resource :github_webhook, only: [ :create ]
  post "/commits/:id/reviewed" => 'commits#reviewed'
  delete "/commits/:id/unreviewed" => 'commits#unreviewed'
end
