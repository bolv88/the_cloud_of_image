require 'test_helper'

class ConvertRulesControllerTest < ActionController::TestCase
  setup do
    @convert_rule = convert_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:convert_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create convert_rule" do
    assert_difference('ConvertRule.count') do
      post :create, convert_rule: { description: @convert_rule.description, status: @convert_rule.status, string: @convert_rule.string, symbol: @convert_rule.symbol, title: @convert_rule.title, user_id: @convert_rule.user_id }
    end

    assert_redirected_to convert_rule_path(assigns(:convert_rule))
  end

  test "should show convert_rule" do
    get :show, id: @convert_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @convert_rule
    assert_response :success
  end

  test "should update convert_rule" do
    put :update, id: @convert_rule, convert_rule: { description: @convert_rule.description, status: @convert_rule.status, string: @convert_rule.string, symbol: @convert_rule.symbol, title: @convert_rule.title, user_id: @convert_rule.user_id }
    assert_redirected_to convert_rule_path(assigns(:convert_rule))
  end

  test "should destroy convert_rule" do
    assert_difference('ConvertRule.count', -1) do
      delete :destroy, id: @convert_rule
    end

    assert_redirected_to convert_rules_path
  end
end
