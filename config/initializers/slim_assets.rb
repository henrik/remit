# https://coderwall.com/p/cthwfq
Rails.application.assets.register_engine(".slim", Slim::Template)

Rails.application.assets.context_class.class_eval do
  include ActionView::Helpers
  include Rails.application.routes.url_helpers
end
