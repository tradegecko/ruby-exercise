require 'vcr'

VCR.configure do |c|
  config.cassette_library_dir = "support/cassettes"
  config.hook_into :webmock
end
