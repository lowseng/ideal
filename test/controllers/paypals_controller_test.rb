require 'test_helper'

class PaypalsControllerTest < ActionController::TestCase
  setup do
    @paypal = paypals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paypals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paypal" do
    assert_difference('Paypal.count') do
      post :create, paypal: { invoice: @paypal.invoice, item_number: @paypal.item_number }
    end

    assert_redirected_to paypal_path(assigns(:paypal))
  end

  test "should show paypal" do
    get :show, id: @paypal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paypal
    assert_response :success
  end

  test "should update paypal" do
    patch :update, id: @paypal, paypal: { invoice: @paypal.invoice, item_number: @paypal.item_number }
    assert_redirected_to paypal_path(assigns(:paypal))
  end

  test "should destroy paypal" do
    assert_difference('Paypal.count', -1) do
      delete :destroy, id: @paypal
    end

    assert_redirected_to paypals_path
  end
end
