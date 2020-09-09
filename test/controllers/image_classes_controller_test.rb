require 'test_helper'

class ImageClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image_class = image_classes(:one)
  end

  test "should get index" do
    get image_classes_url, as: :json
    assert_response :success
  end

  test "should create image_class" do
    assert_difference('ImageClass.count') do
      post image_classes_url, params: { image_class: { domain_id: @image_class.domain_id, name: @image_class.name } }, as: :json
    end

    assert_response 201
  end

  test "should show image_class" do
    get image_class_url(@image_class), as: :json
    assert_response :success
  end

  test "should update image_class" do
    patch image_class_url(@image_class), params: { image_class: { domain_id: @image_class.domain_id, name: @image_class.name } }, as: :json
    assert_response 200
  end

  test "should destroy image_class" do
    assert_difference('ImageClass.count', -1) do
      delete image_class_url(@image_class), as: :json
    end

    assert_response 204
  end
end
