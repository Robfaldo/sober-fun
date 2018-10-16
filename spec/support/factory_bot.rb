require 'factory_bot'

RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
end

FactoryBot.define do
  factory :user do
    email { "test_email@test.com" }
    password { "validpassword" }
  end
end
