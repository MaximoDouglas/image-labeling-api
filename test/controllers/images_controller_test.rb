require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = images(:one)
  end

  test "should get index" do
    get images_url, as: :json
    assert_response :success
  end

  test "should create image" do
    assert_difference('Image.count') do
      post images_url, params: { image: { image_class_id: @image.image_class_id, url: @image.url } }, as: :json
    end

    assert_response 201
  end

  test "should show image" do
    get image_url(@image), as: :json
    assert_response :success
  end

  test "should update image" do
    patch image_url(@image), params: { image: { image_class_id: @image.image_class_id, url: @image.url } }, as: :json
    assert_response 200
  end

  test "should destroy image" do
    assert_difference('Image.count', -1) do
      delete image_url(@image), as: :json
    end

    assert_response 204
  end
end
