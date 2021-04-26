require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test '#create#注册' do
    post :create,params: {login_name:'test1',password:'123456',name:'test1',role_type:0}
    assert_response :success
    assert_equal JSON.parse(response.body)['code'], 0
  end
  test '#show#参看用户' do
    user = User.create( {login_name:'test1',password:Digest::MD5.hexdigest('123456'),name:'test1',role_type:0})
    get :show, params: {id:user.id}
    assert_response :success
    ret = JSON.parse(response.body)
    assert_equal ret['code'], 0
  end
  test '#find_user#查询用户' do
    User.create( {login_name:'test1',password: Digest::MD5.hexdigest('123456'),name:'test1',role_type:0})
    get :find_user, params: {name:'test1',login_name:'test1',password:'123456'}
    assert_response :success
    ret = JSON.parse(response.body)
    assert_equal ret['code'], 0
  end
  test '#update#更新用户' do
    User.create( {login_name:'test1',password: Digest::MD5.hexdigest('123456'),name:'test1',role_type:0})
    put :update, params: {name:'test2',login_name:'test1',password:'123456',role_type:1}
    assert_response :success
    ret = JSON.parse(response.body)
    assert_equal ret['code'], 0
  end
end
