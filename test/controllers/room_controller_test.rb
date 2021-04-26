require 'test_helper'

class RoomControllerTest < ActionController::TestCase
  test '#create#创建房间' do
    User.create( {login_name:'test1',password: Digest::MD5.hexdigest('123456'),name:'test1',role_type:0})
    post :create, params:  {login_name:'test1',password:'123456',name:'test1',room_password:'test1',map_type: 0}
    assert_response :success
    assert_equal JSON.parse(response.body)['code'], 0
    User.create( {login_name:'test2',password: Digest::MD5.hexdigest('123456'),name:'test2',role_type:0})
    get :index, params:  {login_name:'test2',password:'123456',page: 1,limit: 20}
    assert_response :success
    assert_equal JSON.parse(response.body)['code'], 0
    post :join, params:  {login_name:'test2',password:'123456',room_id: Room.last.id,room_password: 'test1'}
    assert_response :success
    assert_equal JSON.parse(response.body)['code'], 0
    post :ping, params:  {login_name:'test2',password:'123456',room_id: Room.last.id}
    assert_response :success
    assert_equal JSON.parse(response.body)['code'], 0
    post :exit, params:  {login_name:'test2',password:'123456',room_id: Room.last.id}
    assert_response :success
    assert_equal JSON.parse(response.body)['code'], 0
    post :exit, params:  {login_name:'test1',password:'123456',room_id: Room.last.id}
    assert_response :success
    assert_equal JSON.parse(response.body)['code'], 0
    assert_equal Room.count, 0
  end
end
