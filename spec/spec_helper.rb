require_relative "../app/boot"

require "rspec"
require "vcr"
require "webmock"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<TOKEN>") do |interaction|
    interaction.request.headers["Authorization"]
  end
end

RSpec.configure do |config|
  config.filter_run_excluding proc: true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
