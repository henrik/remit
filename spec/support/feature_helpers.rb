module FeatureSpecHelpers
  def wait_for_non_dom_ajax_to_complete
    # :/ Capybara is good at waiting for DOM Ajax but non-DOM Ajax is trickier.
    sleep 0.1
  end

  def configure_settings(email:)
    visit_and_wait_for_message_bus_init "/settings"
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

  def visit_and_wait_for_message_bus_init(path)
    visit path
    wait_for_message_bus_initialization
  end

  def wait_for_message_bus_initialization
    should_wait = page.evaluate_script(<<-EOS
      (function() {
        if (!window.MessageBus) {
          return false; // message bus isn't here, there is no way to wait for it to be initialized
        }
        else {
          window.MessageBus.isReady = function() {
            return _.any(this.callbacks, function(callback) { return callback.last_id !== -1; });
          };
          return true;
        }
      })();
     EOS
    )
    return unless should_wait

    wait_until do
      page.evaluate_script("window.MessageBus.isReady();")
    end
  end

  def wait_until
    Timeout.timeout(Capybara.default_wait_time) do
      sleep(0.1) until value = yield
      value
    end
  rescue Capybara::NotSupportedByDriverError
    # Do nothing if we run this from a non-JS test.
  end
end

RSpec.configure do |config|
  config.include FeatureSpecHelpers
end
