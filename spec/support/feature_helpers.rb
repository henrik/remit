module FeatureSpecHelpers
  def wait_for_non_dom_ajax_to_complete
    # :/ Capybara is good at waiting for DOM Ajax but non-DOM Ajax is trickier.
    sleep 0.1
  end

  def configure_settings(email:)
    visit "/settings"
    fill_in "Your email", with: email
  end

  def visitors(*names, &block)
    names.each do |name|
      visitor(name, &block)
    end
  end

  # http://blog.bruzilla.com/post/20889863144/using-multiple-capybara-sessions-in-rspec-request-specs
  def visitor(name)
    old_session = Capybara.session_name
    Capybara.session_name = name
    yield
    Capybara.session_name = old_session
  end
end

RSpec.configure do |config|
  config.include FeatureSpecHelpers
end
