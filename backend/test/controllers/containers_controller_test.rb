require "test_helper"

class ContainersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @container = containers(:one)
  end

  test "should get index" do
    get containers_url, as: :json
    assert_response :success
  end

  test "should create container" do
    assert_difference("Container.count") do
      post containers_url, params: { container: { name: @container.name } }, as: :json
    end

    assert_response :created
  end

  test "should show container" do
    get container_url(@container), as: :json
    assert_response :success
  end

  test "should update container" do
    patch container_url(@container), params: { container: { name: @container.name } }, as: :json
    assert_response :success
  end

  test "should destroy container" do
    assert_difference("Container.count", -1) do
      delete container_url(@container), as: :json
    end

    assert_response :no_content
  end
end
