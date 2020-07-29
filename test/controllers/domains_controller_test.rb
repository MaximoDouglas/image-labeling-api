require 'test_helper'

class DomainsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @domain = domains(:one)
  end

  test "should get index" do
    get domains_url, as: :json
    assert_response :success
  end

  test "should create domain" do
    assert_difference('Domain.count') do
      post domains_url, params: { domain: { description: @domain.description } }, as: :json
    end

    assert_response 201
  end

  test "should show domain" do
    get domain_url(@domain), as: :json
    assert_response :success
  end

  test "should update domain" do
    patch domain_url(@domain), params: { domain: { description: @domain.description } }, as: :json
    assert_response 200
  end

  test "should destroy domain" do
    assert_difference('Domain.count', -1) do
      delete domain_url(@domain), as: :json
    end

    assert_response 204
  end
end
