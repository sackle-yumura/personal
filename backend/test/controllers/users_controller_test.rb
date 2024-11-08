require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # https://github.com/willnet/committee-rails
  include Committee::Rails::Test::Methods

  def committee_options
    @committee_options ||= { schema_path: Rails.root.join('docs', 'openapi.yaml').to_s }
  end

  test 'conforms to schema with 200 response code' do
    get '/users'
    assert_schema_conform(200)
  end

  test 'conforms to request schema' do
    get '/users'
    assert_request_schema_confirm
  end

  test 'conforms to response schema with 200 response code' do
    get '/users'
    assert_response_schema_confirm(200)
  end
end
