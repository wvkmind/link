
class UserController < ApplicationController
  prepend_before_action :skip_check_token, only: [:create,:show]
  def create
    data = {
      login_name: params[:login_name],
      password: Digest::MD5.hexdigest(params[:password]),
      name: params[:name],
      role_type: params[:role_type]
    }
    new_user = User.new data
    if new_user.valid?
      new_user.save!
      render json: {code: 0, msg: '注册成功'}
    else
      render json: {code: 1, msg: '注册失败'}
    end
  end

  def show
    user = User.find params[:id]
    if user
      render json: {
        code: 0,
        data: {
          name: user.name,
          level: user.level,
          role_type: user.role_type
        }
      }
    else
      render json: { code: 1, msg: '用户未找到' }
    end
  end

  def find_user
    user = User.find_by name: params[:name]
    if user
      render json: {
        code: 0,
        data: {
          name: user.name,
          level: user.level,
          role_type: user.role_type
        }
      }
    else
      render json: { code: 1, msg: '用户未找到' }
    end
  end

  def update
    user = User.find_by login_name: params[:login_name]
    user.name = params[:name]
    user.role_type = params[:role_type]
    user.save
    render json: {code: 0, msg: '修改成功'}
  end
end
