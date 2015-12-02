require 'test_helper'

class ExtratosControllerTest < ActionController::TestCase
  setup do
    @extrato = extratos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extratos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extrato" do
    assert_difference('Extrato.count') do
      post :create, extrato: {  }
    end

    assert_redirected_to extrato_path(assigns(:extrato))
  end

  test "should show extrato" do
    get :show, id: @extrato
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @extrato
    assert_response :success
  end

  test "should update extrato" do
    patch :update, id: @extrato, extrato: {  }
    assert_redirected_to extrato_path(assigns(:extrato))
  end

  test "should destroy extrato" do
    assert_difference('Extrato.count', -1) do
      delete :destroy, id: @extrato
    end

    assert_redirected_to extratos_path
  end
end
